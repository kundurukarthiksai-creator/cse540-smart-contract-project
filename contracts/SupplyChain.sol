// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SupplyChain Provenance System
 * @author Team 12
 * @notice This contract tracks products across a supply chain using blockchain.
 * It allows stakeholders to register products, update status, and transfer ownership.
 */
contract SupplyChain {

    // Enum representing product status
    enum Status { Created, Shipped, Received, Delivered }

    // Struct representing a product
    struct Product {
        uint256 id;
        address owner;
        Status status;
    }

    // Mapping from product ID to Product
    mapping(uint256 => Product) public products;

    // Counter for product IDs
    uint256 public productCount;

    // Events
    event ProductRegistered(uint256 productId, address owner);
    event StatusUpdated(uint256 productId, Status status);
    event OwnershipTransferred(uint256 productId, address newOwner);

    /**
     * @notice Registers a new product in the supply chain
     */
    function registerProduct() public {
        productCount++;

        products[productCount] = Product({
            id: productCount,
            owner: msg.sender,
            status: Status.Created
        });

        emit ProductRegistered(productCount, msg.sender);
    }

    /**
     * @notice Updates the status of a product
     * @param _productId The ID of the product
     * @param _status The new status
     */
    function updateStatus(uint256 _productId, Status _status) public {
        require(products[_productId].owner == msg.sender, "Not product owner");

        products[_productId].status = _status;

        emit StatusUpdated(_productId, _status);
    }

    /**
     * @notice Transfers ownership of a product
     * @param _productId The ID of the product
     * @param _newOwner Address of the new owner
     */
    function transferOwnership(uint256 _productId, address _newOwner) public {
        require(products[_productId].owner == msg.sender, "Not product owner");

        products[_productId].owner = _newOwner;

        emit OwnershipTransferred(_productId, _newOwner);
    }

    /**
     * @notice Retrieves product details
     * @param _productId The ID of the product
     */
    function getProduct(uint256 _productId) public view returns (
        uint256,
        address,
        Status
    ) {
        Product memory p = products[_productId];
        return (p.id, p.owner, p.status);
    }
}
