// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User{
    struct Player {
        address playerAddress;
        string playerName;
        uint score;
    }

    mapping (address => Player) public Players;

    function createPlayer(address _playerAddress, string memory _playerName)  public {
        require(Players[_playerAddress].playerAddress == address(0), "User already exist");
        
        Player memory newPlayer = Player({
            playerAddress : _playerAddress,
            playerName : _playerName,
            score : 0
        });

        Players[_playerAddress] = newPlayer;
        
    }
}