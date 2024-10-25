// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// PAYABLE MODIFIER AND msg OBJECT
contract SmartMoney {
    string public myMessage = "Hello world";

    // The payable modifier tells solidity that the function is expecting eth to receive.
    function getMessage(string memory _myMessage) public payable {
        if(msg.value == 1 ether){
            myMessage = _myMessage;
        }
        else {                              
            payable(msg.sender).transfer(msg.value);
        }
    }
}

// RECEIVE AND FALLBACK FUNCTION
contract SampleFallback {
    uint public value;
    string public message;

    receive() external payable { 
        value = msg.value;
        message = "recieved";
    }

    fallback() external payable { 
        value = msg.value;
        message = "fallback";
    }
}
