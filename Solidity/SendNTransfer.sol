// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sender {

    receive() external payable { }

    function withDrawTransfer(address payable to) public {
        to.transfer(10);
    }

    function withDrawSend(address payable to) public {
        bool isSend = to.send(10);
        require(isSend, "Transaction was unsuccessful!!!");
    }
}

contract ReceiveAction {
    uint public balanceReceived;

    function balance() public view returns (uint){
        return address(this).balance;
    }

    // TRANSACTION FAILS BECAUSE WE ARE CHANGING AN STATE VARIABLE WHICH COST MORE THAN 2300 GAS.
    // IN BOTH CASE transfer() and send(), transaction fails.
    receive() external payable {
        balanceReceived += msg.value;
    }
}

contract ReceiveNoAction {

    function balance() public view returns (uint){
        return address(this).balance;
    }

    receive() external payable {  }
}
