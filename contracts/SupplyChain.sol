// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SupplyChain Provenance System
 * @notice Smart contract draft for tracking products across a supply chain
 * with role-based access control, product registration, status updates,
 * verification, and ownership transfer.
 */
contract SupplyChain {
    // Six stakeholders from the proposal
    enum Role {
        None,
        Supplier,
        Manufacturer,
        Distributor,
        Retailer,
        Regulator,
        Consumer
    }

    // Product lifecycle states
    enum Status {
        Created,
        Shipped,
        Received,
        Delivered
    }

    // Product record stored on-chain
    struct Product {
        uint256 id;
        address owner;
        Status status;
        bool exists;
        bool verified;
    }

    address public admin;
    uint256 public productCount;

    mapping(address => Role) public roles;
    mapping(uint256 => Product) public products;

    event RoleAssigned(address indexed user, Role role);
    event ProductRegistered(uint256 indexed productId, address indexed owner);
    event StatusUpdated(uint256 indexed productId, Status status);
    event OwnershipTransferred(uint256 indexed productId, address indexed newOwner);
    event ProductVerified(uint256 indexed productId, address indexed regulator);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can assign roles");
        _;
    }

    modifier onlyProductOwner(uint256 _productId) {
        require(products[_productId].exists, "Product does not exist");
        require(products[_productId].owner == msg.sender, "Not product owner");
        _;
    }

    modifier productExists(uint256 _productId) {
        require(products[_productId].exists, "Product does not exist");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @notice Assign a stakeholder role to a user
     * @dev Restricted to contract admin for basic access control
     */
    function assignRole(address _user, Role _role) public onlyAdmin {
        require(_role != Role.None, "Invalid role");
        roles[_user] = _role;
        emit RoleAssigned(_user, _role);
    }

    /**
     * @notice Register a new product
     * @dev Only a supplier can register products
     */
    function registerProduct() public {
        require(roles[msg.sender] == Role.Supplier, "Only supplier can register");

        productCount += 1;

        products[productCount] = Product({
            id: productCount,
            owner: msg.sender,
            status: Status.Created,
            exists: true,
            verified: false
        });

        emit ProductRegistered(productCount, msg.sender);
    }

    /**
     * @notice Update product lifecycle status
     * @dev Only the current product owner can update status
     */
    function updateStatus(uint256 _productId, Status _status)
        public
        onlyProductOwner(_productId)
    {
        products[_productId].status = _status;
        emit StatusUpdated(_productId, _status);
    }

    /**
     * @notice Transfer product ownership to another stakeholder
     * @dev New owner must already have a valid stakeholder role
     */
    function transferOwnership(uint256 _productId, address _newOwner)
        public
        onlyProductOwner(_productId)
    {
        require(roles[_newOwner] != Role.None, "New owner must be a stakeholder");

        products[_productId].owner = _newOwner;
        emit OwnershipTransferred(_productId, _newOwner);
    }

    /**
     * @notice Verify a product record
     * @dev Only a regulator can verify; verification is tracked separately
     */
    function verifyProduct(uint256 _productId) public productExists(_productId) {
        require(roles[msg.sender] == Role.Regulator, "Only regulator allowed");

        products[_productId].verified = true;
        emit ProductVerified(_productId, msg.sender);
    }

    /**
     * @notice Read product details
     */
    function getProduct(uint256 _productId)
        public
        view
        productExists(_productId)
        returns (
            uint256,
            address,
            Status,
            bool
        )
    {
        Product memory p = products[_productId];
        return (p.id, p.owner, p.status, p.verified);
    }

    /**
     * @notice Consumer-facing view of product provenance
     */
    function viewProduct(uint256 _productId)
        public
        view
        productExists(_productId)
        returns (
            uint256,
            address,
            Status,
            bool
        )
    {
        return getProduct(_productId);
    }
}
