const { expect } = require("chai");

describe("SupplyChain", function () {
  let contract, admin, supplier, regulator, distributor;

  beforeEach(async function () {
    [admin, supplier, regulator, distributor] = await ethers.getSigners();

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

  it("allows ownership transfer to a valid stakeholder", async function () {
    await contract.connect(supplier).registerProduct();
    await contract.connect(supplier).transferOwnership(1, distributor.address);

    const product = await contract.getProduct(1);
    expect(product[1]).to.equal(distributor.address);
  });

  it("allows regulator verification", async function () {
    await contract.connect(supplier).registerProduct();
    await contract.connect(regulator).verifyProduct(1);

    const product = await contract.getProduct(1);
    expect(product[3]).to.equal(true);
  });
});
