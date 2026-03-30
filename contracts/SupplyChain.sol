// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SupplyChain Provenance System
 * @author Team 12
 * @notice Tracks product lifecycle across multiple stakeholders using blockchain
 */
contract SupplyChain {

    // Define roles (6 stakeholders from design)
    enum Role { None, Supplier, Manufacturer, Distributor, Retailer, Regulator, Consumer }

    // Product lifecycle status
    enum Status { Created, Shipped, Received, Delivered }

    // Product structure
    struct Product {
        uint256 id;
        address owner;
        Status status;
    }

    // Store roles of users
    mapping(address => Role) public roles;

    // Store products
    mapping(uint256 => Product) public products;

    // Counter for product IDs
    uint256 public productCount;

    // Events
    event RoleAssigned(address user, Role role);
    event ProductRegistered(uint256 productId, address owner);
    event StatusUpdated(uint256 productId, Status status);
    event OwnershipTransferred(uint256 productId, address newOwner);

    /**
     * @notice Assign a role to a user
     */
    function assignRole(address _user, Role _role) public {
        roles[_user] = _role;
        emit RoleAssigned(_user, _role);
    }

    /**
     * @notice Register a new product (only Supplier)
     */
    function registerProduct() public {
        require(roles[msg.sender] == Role.Supplier, "Only supplier can register");

        productCount++;

        products[productCount] = Product({
            id: productCount,
            owner: msg.sender,
            status: Status.Created
        });

        emit ProductRegistered(productCount, msg.sender);
    }

    /**
     * @notice Update product status (only current owner)
     */
    function updateStatus(uint256 _productId, Status _status) public {
        require(products[_productId].owner == msg.sender, "Not owner");

        products[_productId].status = _status;

        emit StatusUpdated(_productId, _status);
    }

    /**
     * @notice Transfer ownership to another stakeholder
     */
    function transferOwnership(uint256 _productId, address _newOwner) public {
        require(products[_productId].owner == msg.sender, "Not owner");
        require(roles[_newOwner] != Role.None, "Invalid stakeholder");

        products[_productId].owner = _newOwner;

        emit OwnershipTransferred(_productId, _newOwner);
    }

    /**
     * @notice Regulator verifies a product (example validation step)
     */
    function verifyProduct(uint256 _productId) public {
        require(roles[msg.sender] == Role.Regulator, "Only regulator allowed");

        products[_productId].status = Status.Delivered;

        emit StatusUpdated(_productId, Status.Delivered);
    }

    /**
     * @notice Consumers can view product details
     */
    function viewProduct(uint256 _productId) public view returns (
        uint256,
        address,
        Status
    ) {
        Product memory p = products[_productId];
        return (p.id, p.owner, p.status);
    }

    /**
     * @notice Get product details
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
