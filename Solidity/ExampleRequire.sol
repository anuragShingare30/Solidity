// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleRequire {

    mapping (address => uint) public Balance;

    function deposit() public payable {
        Balance[msg.sender] += msg.value;
    }

    function withDrawMoney(address payable to, uint amount) public payable {

        // require() statement behaves opposite to if-else statements.
        // If condition is false, it will throw an exception/error and will revert the transaction.
        require(amount <= Balance[msg.sender], "Not enough funds!!!");
        Balance[msg.sender] -= amount;
        to.transfer(amount);
    }
}