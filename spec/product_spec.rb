require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do
      @category = Category.new(name: 'Video games')
      @category.save
    end
    
    it 'creates a product if all four fields are present' do
      @product = @category.products.create!(name: "World of Warcraft", price_cents: 60, quantity: 10, category: @category)
    
      expect(@product).to be_valid
    end

    it 'gives an error if there is no name for the product' do
      @product = @category.products.new(name: nil, price_cents: 30, quantity: 3, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'gives an error if there is no price for the product' do
      @product = @category.products.new(name: "World of WarCraft", price_cents: nil, quantity: 3, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Price cents can't be blank")
    end

    it 'gives an error if there is no quantity for the product' do
      @product = @category.products.new(name: "World of Warcraft", price_cents: 60, quantity: nil, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'gives an error if there is no category for the product' do
      @product = Product.new(name: "World of WarCraft", price_cents: 60, quantity: 3, category_id: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end