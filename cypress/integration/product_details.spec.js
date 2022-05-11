describe("product details", () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  });

  it("users can go from the home page to the product details page", () => {
    cy.contains("Look no further than our online plant shop!");

    cy.get("a[href='/products/1']").click();

    cy.location('href').should("eq", "http://localhost:3000/products/1");
  });
});