// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestStructMapping {

    // THIS IS ALSO AN ONE TYPE OF DATA-TYPE.
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    mapping (address => Transaction) public Balance;

    function deposit() public payable {

        Transaction memory balance = Balance[msg.sender];
        balance.amount = msg.value;
        balance.timestamp = block.timestamp;    
    }

    function checkBalance(address _address) public view returns (uint){
        return Balance[_address].amount;
    }
}