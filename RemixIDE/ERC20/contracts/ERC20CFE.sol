// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeTKN is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffeePurchased(address reciever, address buyer);

    constructor() ERC20("CoffeeTKN", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn() public {
        _burn(msg.sender, 1);
    }

    function buyOneCoffee() public {
        _burn(msg.sender, 1);
        emit CoffeePurchased(msg.sender, msg.sender);
    }

    function buyOneCoffeeFrom(address owner) public {
        _spendAllowance(owner, msg.sender, 1);
        _burn(owner, 1);
        emit CoffeePurchased(msg.sender, owner);
    }
}