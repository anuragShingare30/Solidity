// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// PARENT CONTRACT
contract MultiPlayerGame {
    mapping (address => bool) public players;

    // A virtual function is one that allows an inherited contract to override the operation of a function that is defined as such.
    function joinGame() public virtual{
        players[msg.sender] = true;
    }

}

// CHILD CONTRACT
contract PlayGame is MultiPlayerGame{
    string public gameName;
    uint public totalplayers;

    constructor(string memory _gameName) {
        gameName = _gameName;
        totalplayers = 0;
    }

    function startGame() public view returns (bool){
        // add our game code here...
    }

    // The function that overrides the base function should be labeled as an override in Solidity in order to distinguish it from the base function.
    // The override specifier must be used to indicate that a function is intended to override another function. If an overridden function is called from within the overriding function, it can be done using super.functionName(arguments)
    function joinGame() public override {
        
        // function from parent contract
        super.joinGame();
        // add our own functionality
        totalplayers++;
    }

}