# CSE540 Blockchain-Based Supply Chain Provenance System

[![CI](https://github.com/kundurukarthiksai-creator/cse540-smart-contract-project/actions/workflows/ci.yml/badge.svg)](https://github.com/kundurukarthiksai-creator/cse540-smart-contract-project/actions/workflows/ci.yml)

Smart-contract course project for CSE 540 at Arizona State University. The project models a blockchain-based supply chain provenance system where stakeholders can register products, transfer custody, update lifecycle status, and verify product records.

## Verified Status

- Contract source: `contracts/SupplyChain.sol`
- Framework: Hardhat with Solidity `0.8.20`
- Tests: 8 Hardhat tests covering happy paths and rejected unauthorized actions
- CI: GitHub Actions installs locked dependencies, compiles the contract, and runs the test suite
- Scope: smart-contract prototype, not a deployed production application

## Problem

Traditional supply chains often depend on fragmented, centralized records. That makes it hard for manufacturers, distributors, retailers, regulators, and consumers to verify product ownership, custody history, and authenticity from a shared source of truth.

## Implemented Solution

The current contract implements a compact provenance workflow:

- Admin-controlled role assignment for supply chain stakeholders
- Supplier-only product registration
- Owner-only lifecycle status updates
- Ownership transfer to registered stakeholders
- Regulator-only product verification
- Read-only product views for provenance lookup

## Contract Behavior

`SupplyChain.sol` defines six stakeholder roles:

- Supplier
- Manufacturer
- Distributor
- Retailer
- Regulator
- Consumer

It tracks each product with:

- Product ID
- Current owner
- Lifecycle status
- Existence flag
- Regulator verification flag

## Tested Scenarios

The test suite verifies:

- Suppliers can register products
- Non-suppliers cannot register products
- Only the admin can assign stakeholder roles
- Product owners can transfer ownership to valid stakeholders
- Ownership cannot be transferred to unregistered addresses
- Only product owners can update lifecycle status
- Regulators can verify products
- Non-regulators cannot verify products

## Project Structure

```text
contracts/              Solidity smart contract source
scripts/                Local deployment script
test/                   Hardhat contract tests
.github/workflows/      CI workflow for compile and test verification
```

## Local Setup

```bash
git clone https://github.com/kundurukarthiksai-creator/cse540-smart-contract-project.git
cd cse540-smart-contract-project
npm ci
npm run compile
npm test
```

## Deployment

Run the local deployment script with:

```bash
npx hardhat run scripts/deploy.js
```

No public testnet deployment address is currently committed in this repository.

## Honest Limits

This repository currently proves the smart-contract prototype only. It does not yet include:

- A production frontend
- MetaMask wallet flow
- IPFS metadata storage
- IoT or oracle integrations
- Separate registry, product, and provenance contracts
- Public testnet deployment evidence

Those are future directions, not completed features.

## Future Improvements

- Split the contract into clearer registry, product, and provenance modules
- Add richer event history queries for product lifecycle tracking
- Add deployment configuration for a public testnet
- Add a frontend for stakeholder workflows
- Add gas usage reporting and broader edge-case tests

## Team Members

- Karthik Venkata Sai Reddy Kunduru
- Shiva Reddy Marri
- Kamal Teja Annamdasu
- Pardha Praneeth Pudi
- Erin Ozcan

## Course

CSE 540: Engineering Blockchain Applications

Arizona State University
