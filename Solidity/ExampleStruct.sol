// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleStruct {
    // Defining struct
    struct PaymentReceipt {
        address from;
        uint256 amount;
    }

    // ACCESSING AN STRUCT
    PaymentReceipt public payment;

    // USING STRUCT TO STORE VALUE.
    function getPaymentReceipt() public payable {
        // payment = PaymentReceipt(msg.sender, msg.value);
        payment.from = msg.sender;
        payment.amount = msg.value;
    }

    // ANOTHER WAY TO USE STRUCT (BY MAPPING)
    mapping(address => PaymentReceipt) public Balance;

    function getPaymentHistory() public payable {
        Balance[msg.sender].amount = msg.value;
    }
}
