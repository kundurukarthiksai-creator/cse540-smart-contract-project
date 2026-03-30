# CSE540 Blockchain-Based Supply Chain Provenance System

## Description

This project implements a blockchain-based supply chain provenance system designed to improve transparency, traceability, and trust across multiple stakeholders. Traditional supply chains rely on centralized and fragmented systems, making it difficult to track products and verify authenticity.

Our system uses blockchain technology to create a shared, immutable ledger where product lifecycle events are recorded securely. This ensures that all stakeholders have access to a consistent and tamper-proof history of a product.

## Problem Statement

Modern supply chains involve multiple stakeholders such as suppliers, manufacturers, distributors, retailers, and consumers. However, existing systems store data in isolated, centralized databases, leading to lack of transparency, difficulty in verifying product authenticity, and increased risk of fraud.

## Solution

We propose a decentralized supply chain system that:

* Assigns a unique identifier to each product
* Tracks product lifecycle events on-chain
* Enables secure ownership and custody transfer
* Stores critical data immutably using smart contracts

## Features

* Product registration with unique ID
* Ownership and custody transfer tracking
* Status updates (Created, Shipped, Delivered, etc.)
* Immutable event logging on blockchain
* Multi-stakeholder interaction (supplier, manufacturer, distributor, retailer, consumer)

## Technologies Used

* Solidity
* Ethereum
* Hardhat
* Ethers.js
* MetaMask
* IPFS (for off-chain storage)

## Roles in Supply Chain
- Supplier -> Registers products
- Manufacturer -> Processes and updates products
- Distributor -> Handles shipment and custody transfer
- Retailer -> Receives and delivers products
- Regulator -> Verifies and validates product records
- Consumer -> Views product provenance and authenticity

## Smart Contracts
The current draft uses one Solidity contract, `SupplyChain.sol`, which combines stakeholder registration, product registration, and provenance tracking logic for this milestone.

## System Architecture

The system follows a hybrid on-chain/off-chain architecture:

**On-chain:**

* Smart contracts for product registration and tracking
* Ownership and lifecycle event management

**Off-chain:**

* Storage of large files such as invoices and metadata using IPFS

## Smart Contracts

The system includes the following contracts:

* Stakeholder Registry Contract
* Product Registry Contract
* Provenance Tracking Contract

These contracts manage product lifecycle events, ownership transfers, and validation of updates.

## Project Structure

* contracts/ → Solidity smart contracts
* scripts/ → Deployment scripts
* test/ → Test files
* README.md → Project documentation

## Setup Instructions

1. Clone the repository:
   git clone https://github.com/kundurukarthiksai-creator/cse540-smart-contract-project.git

2. Navigate into the project directory:
   cd cse540-smart-contract-project

3. Install dependencies:
   npm install

4. Compile contracts:
   npx hardhat compile

## Deployment

To deploy the smart contract locally:

npx hardhat run scripts/deploy.js

You can also deploy to a testnet (e.g., Polygon Amoy) using MetaMask.

## Usage

Users can interact with the system by:

* Registering products
* Updating product status
* Transferring ownership between stakeholders
* Viewing product history on the blockchain

## Future Improvements

* Integration with IoT devices for real-time tracking
* Enhanced access control mechanisms
* Frontend web interface for better usability
* Improved scalability and gas optimization

## Team Members

* Karthik Venkata Sai Reddy Kunduru
* Shiva Reddy Marri
* Kamal Teja Annamdasu
* Pardha Praneeth Pudi
* Erin Ozcan

## Course

CSE 540: Engineering Blockchain Applications
Arizona State University
