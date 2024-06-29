// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Types of Functions {

    uint public balance;

    constructor(uint initial_balance) {

        require(initial_balance >= 1000, "initial balance must be greater than or equal to 1000");
        balance = initial_balance;
    }

    function withdraw(uint amount) public {
        require(amount <= balance, "balance cannot be less than amount");
        balance -= amount;
    }
    function assertFunction() public view{
        assert(balance >= 1000); 
        // Should never be false, if it is, there's a bug
        // ...
    }

    error low_balance(uint balance, uint amount);
    function revertFunction(uint _amount) public view{
        uint _balance = address(this).balance;
        if (_amount> _balance) {
            revert low_balance({balance: _balance,amount: _amount});
        }
       
    }
}
