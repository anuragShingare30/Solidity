// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleAssert {
    mapping (address => uint8) public Balance;

    function deposit() public payable {
        assert(msg.value == uint8(msg.value));
        Balance[msg.sender] += uint8(msg.value);
        assert(Balance[msg.sender] >= uint8(msg.value));
    }

    function withDrawMoney(address payable to, uint8 amount) public payable {
        
        require(amount <= Balance[msg.sender], "Not enough funds!!!");
        assert(Balance[msg.sender] >= Balance[msg.sender] - amount);
        Balance[msg.sender] -= amount;
        to.transfer(amount);
    }
}