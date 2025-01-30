// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventsExample {
    mapping (address => uint) public Balance;

    event TokensSend(address _from, address _to, uint _amount);

    // FREE TOKENS FOR ACCOUNT DEPLOYING THE SMART CONTRACT.
    constructor(){
        Balance[msg.sender] = 100;
    }

    function sendTokens(address _to, uint _amount) public payable {
        require(_amount <= Balance[msg.sender], "You don't have enough funds!!!");
        Balance[msg.sender] -= _amount;
        Balance[_to] += _amount;

        emit TokensSend(msg.sender, _to, _amount);  
    }
}