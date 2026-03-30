const { expect } = require("chai");

describe("SupplyChain", function () {
  let contract, owner;

  beforeEach(async function () {
    const SupplyChain = await ethers.getContractFactory("SupplyChain");
    contract = await SupplyChain.deploy();
    await contract.waitForDeployment();

    [owner] = await ethers.getSigners();
  });

  it("Should assign role and register product", async function () {
    await contract.assignRole(owner.address, 1); // Supplier

    await contract.registerProduct();

    const product = await contract.getProduct(1);

    expect(product[0]).to.equal(1);
    expect(product[1]).to.equal(owner.address);
  });
});
