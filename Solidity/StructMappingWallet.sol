// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructMappingWallet {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint totalDeposit;
        mapping (uint => Transaction) deposit;
        uint totalWithDrawl;
        mapping (uint => Transaction) withdrawl;
    }

    mapping (address => Balance) public balance;


    function checkBalance(address _address) public view returns(uint){
        return balance[_address].totalBalance;
    }



    function depositMoney() public payable {
        balance[msg.sender].totalBalance += msg.value;
        
        balance[msg.sender].deposit[balance[msg.sender].totalDeposit].amount = msg.value;
        balance[msg.sender].deposit[balance[msg.sender].totalDeposit].timestamp = block.timestamp;
        balance[msg.sender].totalDeposit++;
    }

    function withdrawMoney(address payable  _to, uint amountToSend) public payable{
        balance[msg.sender].totalBalance -= amountToSend;

        balance[msg.sender].withdrawl[balance[msg.sender].totalWithDrawl].amount = msg.value;
        balance[msg.sender].withdrawl[balance[msg.sender].totalWithDrawl].timestamp = block.timestamp;
        balance[msg.sender].totalWithDrawl++;

        _to.transfer(amountToSend);
    }

}