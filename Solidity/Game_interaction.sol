// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUser {
    function createPlayer(address _playerAddress, string memory _playerName) external;
}

contract Game {
    uint gameCount;
    IUser public userContract;

    constructor(address _userContractAddress) {
        userContract = IUser(_userContractAddress);
    }

    function startGame(string memory _playerName) public {
        gameCount++;
        userContract.createPlayer(msg.sender, _playerName);
    }
}