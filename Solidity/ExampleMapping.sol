// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleMapping {

    // 1.
    mapping(uint => string) public storing;
    
    function getStoring(string memory _myStoring) public {
        storing[1] = _myStoring;
        storing[2] = "test2";
        storing[3] = "test3";
    }

    // 2.
    mapping(address => bool) public check;
    function getChecked() public {
        check[msg.sender] = true;
    }

    // 3.
    mapping(uint => mapping(uint => bool)) public mapOfMap;
    function setMapOfMap(uint num1, uint num2, bool value) public {
        mapOfMap[num1][num2] = value;
    }
    function getMapOfMap(uint num1,uint num2) public view returns (bool){
        return mapOfMap[num1][num2];
    }
}

//  This  allows everyone to send Ether to the Smart Contract.
contract SecureSmartWallet {    
    
    mapping(address => uint) public balanceReceived;

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

        function checkBalance() public view returns(uint){
            return address(this).balance;
        }

    function withDrawAmount(address payable toAddress) public  {
        uint amountToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        toAddress.transfer(amountToSend);
    }
}

