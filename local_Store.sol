// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LocalStore {
    address public owner; // Contract owner address
    mapping(uint => Item) public items; // Mapping to store items by ID
    uint public itemCount; // Total count of items
    mapping(address => uint) public balances; // Track balances of users

    struct Item {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    // Events to log actions
    event ItemAdded(uint id, string name, uint price, uint stock);
    event ItemPurchased(uint id, address buyer, uint quantity);
    event StockUpdated(uint id, uint newStock);
    event BalanceIncreased(address account, uint amount);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    function purchaseItem(uint id, uint quantity, uint paymentAmount) public payable {
        Item storage item = items[id];
        require(item.id != 0, "Item does not exist");
        require(quantity > 0, "Quantity must be greater than 0");
        require(item.stock >= quantity, "Not enough stock");
        require(paymentAmount == item.price * quantity, "Incorrect payment amount");

        item.stock -= quantity; // Deduct stock of the item

        emit ItemPurchased(id, msg.sender, quantity); // Emit ItemPurchased event
    }
    // Function to add a new item to the store
    function addItem(string memory name, uint price, uint stock) public onlyOwner {
        require(price > 0, "Price must be greater than 0");
        require(stock > 0, "Stock must be greater than 0");

        itemCount++;
        items[itemCount] = Item(itemCount, name, price, stock); // Add item to items mapping

        emit ItemAdded(itemCount, name, price, stock); // Emit ItemAdded event
    }

    // Function to purchase an item
    

    // Function to withdraw contract funds (Ether)
    function withdrawFunds() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdrawal failed"); // Ensure transfer was successful
    }

    // Function to view emergency stop status (view function)
    function emergencyStop() public view onlyOwner {
        revert("Emergency stop initiated");
    }

    // Function to mint (increase) balance for a specific account
    function mint(address account, uint amount) public onlyOwner {
        require(account != address(0), "Invalid account address");
        require(amount > 0, "Amount must be greater than 0");

        balances[account] += amount; // Increase balance of the account

        emit BalanceIncreased(account, amount); // Emit BalanceIncreased event
    }
}
