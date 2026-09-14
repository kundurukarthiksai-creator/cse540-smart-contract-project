const { expect } = require("chai");

describe("SupplyChain", function () {
  let contract, admin, supplier, regulator, distributor, outsider;

  beforeEach(async function () {
    [admin, supplier, regulator, distributor, outsider] = await ethers.getSigners();

    const SupplyChain = await ethers.getContractFactory("SupplyChain");
    contract = await SupplyChain.deploy();
    await contract.waitForDeployment();

    await contract.assignRole(supplier.address, 1);    // Supplier
    await contract.assignRole(regulator.address, 5);   // Regulator
    await contract.assignRole(distributor.address, 3); // Distributor
  });

  it("registers a product for a supplier", async function () {
    await contract.connect(supplier).registerProduct();
    const product = await contract.getProduct(1);

    expect(product[0]).to.equal(1n);
    expect(product[1]).to.equal(supplier.address);
  });

  it("rejects product registration from non-suppliers", async function () {
    await expect(contract.connect(distributor).registerProduct()).to.be.revertedWith(
      "Only supplier can register"
    );
  });

  it("restricts role assignment to the admin", async function () {
    await expect(
      contract.connect(supplier).assignRole(outsider.address, 2)
    ).to.be.revertedWith("Only admin can assign roles");
  });

  it("allows ownership transfer to a valid stakeholder", async function () {
    await contract.connect(supplier).registerProduct();
    await contract.connect(supplier).transferOwnership(1, distributor.address);

    const product = await contract.getProduct(1);
    expect(product[1]).to.equal(distributor.address);
  });

  it("rejects ownership transfer to an unregistered stakeholder", async function () {
    await contract.connect(supplier).registerProduct();

    await expect(
      contract.connect(supplier).transferOwnership(1, outsider.address)
    ).to.be.revertedWith("New owner must be a stakeholder");
  });

  it("lets only the product owner update lifecycle status", async function () {
    await contract.connect(supplier).registerProduct();

    await expect(contract.connect(distributor).updateStatus(1, 1)).to.be.revertedWith(
      "Not product owner"
    );

    await contract.connect(supplier).updateStatus(1, 1);
    const product = await contract.getProduct(1);
    expect(product[2]).to.equal(1n);
  });

  it("allows regulator verification", async function () {
    await contract.connect(supplier).registerProduct();
    await contract.connect(regulator).verifyProduct(1);

    const product = await contract.getProduct(1);
    expect(product[3]).to.equal(true);
  });

  it("rejects verification from non-regulators", async function () {
    await contract.connect(supplier).registerProduct();

    await expect(contract.connect(distributor).verifyProduct(1)).to.be.revertedWith(
      "Only regulator allowed"
    );
  });
});
