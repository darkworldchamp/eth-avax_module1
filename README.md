# LocalStore Solidity Smart Contract

This repository contains a Solidity smart contract named `LocalStore` that facilitates a local store system on the Ethereum blockchain. Below, you'll find an overview of its functions, potential errors, and instructions on how to compile, deploy, and interact with the contract.

## Functions

### `addItem`

- **Description**: Adds a new item to the store.
- **Parameters**:
  - `name`: Name of the item.
  - `price`: Price of the item.
  - `stock`: Initial stock of the item.
- **Access**: Only the contract owner can call this function (`onlyOwner` modifier).
- **Errors**:
  - Reverts if `price` is not greater than 0.
  - Reverts if `stock` is not greater than 0.

### `purchaseItem`

- **Description**: Allows a buyer to purchase an item from the store.
- **Parameters**:
  - `id`: ID of the item to purchase.
  - `quantity`: Quantity of the item to purchase.
  - `paymentAmount`: Amount of Ether sent as payment.
- **Access**: Public function.
- **Errors**:
  - Reverts if `id` does not correspond to an existing item.
  - Reverts if `quantity` is not greater than 0.
  - Reverts if there is not enough `stock` of the item.
  - Reverts if `paymentAmount` does not match the calculated price for the specified quantity.

### `withdrawFunds`

- **Description**: Allows the contract owner to withdraw Ether balance from the contract.
- **Access**: Only the contract owner can call this function (`onlyOwner` modifier).
- **Errors**:
  - Reverts if there are no funds (`balance`) available in the contract.

### `emergencyStop`

- **Description**: Allows the contract owner to view the emergency stop status.
- **Access**: View function; anyone can call this function to view the status.
- **Errors**:
  - Always reverts with "Emergency stop initiated" message.

### `mint`

- **Description**: Allows the contract owner to increase the balance of a specific account.
- **Parameters**:
  - `account`: Address of the account to increase the balance.
  - `amount`: Amount to increase the balance.
- **Access**: Only the contract owner can call this function (`onlyOwner` modifier).
- **Errors**:
  - Reverts if `account` address is invalid (`address(0)`).
  - Reverts if `amount` is not greater than 0.

## Errors

- **Withdrawal failed**: Occurs when the `withdrawFunds` function fails to transfer Ether to the owner.
- **Invalid account address**: Occurs in the `mint` function if the provided `account` address is `address(0)`.
- **Amount must be greater than 0**: Occurs in `addItem` and `mint` functions if the provided amount or price is zero or negative.
- **Not enough stock**: Occurs in `purchaseItem` if the requested quantity exceeds the available stock.
- **Incorrect payment amount**: Occurs in `purchaseItem` if the sent Ether amount does not match the calculated price for the items.

## How to Run

### Using Remix IDE

1. **Compile and Deploy**:
   - Open Remix IDE (https://remix.ethereum.org/).
   - Copy the entire `LocalStore.sol` contract code into a new file in Remix.
   - Navigate to the "Solidity Compiler" tab, compile the contract (`LocalStore.sol`), and resolve any compilation errors.
   - Switch to the "Deploy & Run Transactions" tab, select the correct compiler version (`0.8.0`), and deploy the contract by clicking on the `Deploy` button.

2. **Interact with the Contract**:
   - Once deployed, Remix provides an interface to interact with each function of the contract (`addItem`, `purchaseItem`, `withdrawFunds`, `emergencyStop`, `mint`).
   - Use the provided input fields to call each function with appropriate parameters.
   - Monitor the console for transaction details and events emitted by the contract.

### Using Truffle (Local Development)

1. **Setup**:
   - Ensure you have Node.js and npm installed on your machine.
   - Install Truffle globally: `npm install -g truffle`.

2. **Project Initialization**:
   - Create a new directory for your project: `mkdir LocalStoreProject`.
   - Navigate into the project directory: `cd LocalStoreProject`.
   - Initialize a new Truffle project: `truffle init`.

3. **Contract Deployment**:
   - Place `LocalStore.sol` inside the `contracts` directory.
   - Update `2_deploy_contracts.js` in the `migrations` directory to deploy `LocalStore`.
   - Example content of `2_deploy_contracts.js`:
     ```javascript
     const LocalStore = artifacts.require("LocalStore");

     module.exports = function (deployer) {
       deployer.deploy(LocalStore);
     };
     ```

4. **Compile and Migrate**:
   - Compile the contracts: `remix compile`.
   - Migrate the contracts to the chosen network .

5. **Interact with the Contract**:
   - Use remix console to interact with deployed contracts:
