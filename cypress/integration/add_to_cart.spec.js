describe("add to cart", () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  });

  it(`when add to cart is clicked, cart count increases by one`, () => {
    cy.contains("Add").click({force: true});
    cy.contains("My Cart").should("include.text", "1")
  });
});