// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// THIS IS THE SIMPLE WALLET WHICH CAN RECEIVE ETH.
contract ContractOne {

    mapping (address => uint) public Balance;

    function deposit() public payable {
        Balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns (uint){
        return address(this).balance;
    }

    // 2.
    receive() external payable { 
        deposit();
    }
}

// THIS SMART CONTRACT CAN INTERACT WITH OTHER SC AND CAN SEND THE ETH AND GAS TO OTHER SC.
contract ContractTwo {
    receive() external payable { }

    function DepositInContractOne(address to, uint amount) public {
        // 1.
        // ContractOne one = ContractOne(to);
        // one.deposit{value:amount, gas:100000}();

        // 2.
        (bool send,) = to.call{value:amount, gas:100000}("");
        require(send);
    }
}