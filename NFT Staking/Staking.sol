// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";


contract Staking is Ownable, IERC721Receiver, ERC721Holder{
    IERC721 immutable nft;
    IERC20 immutable token;

    mapping (address => mapping (uint => uint)) public Stakes;

    constructor(address _nft, address _token) Ownable(msg.sender) {
        nft = IERC721(_nft);
        token = IERC20(_token);
    }

    function staking(uint _id) public{
        require(nft.ownerOf(_id) == msg.sender, "YOU ARE NOT OWNER OF NFT!!!");
        // STAKE THE NFT
        Stakes[msg.sender][_id] = block.timestamp;
        nft.safeTransferFrom(msg.sender, address(this), _id);
    }

    function calculateRate(uint _time) private pure returns (uint){
        if(_time < 1 minutes) return 0;
        else if (_time < 3) return 3;
        else if(_time < 5) return 5;
        else return 10;
    }

    // WHENEVER WE ARE SENDING MONEY THROUGH BLOCKCHAIN WE ARE SENDING IN WEI(1ETH = 10^18 WEI)
    function calculateReward(uint _id) public view returns (uint){
        require(Stakes[msg.sender][_id] > 0, "NFT HAS NOT BEEN STAKED!!!");
        uint time = block.timestamp - Stakes[msg.sender][_id];
        uint totalReward = (calculateRate(time) * time * (10 ** 18)) / 1 minutes;
        return totalReward;
    }

    function unStaking(uint _id) public{
        // calculate reward
        uint reward = calculateReward(_id);
        delete Stakes[msg.sender][_id];
        // transfer the nft back to original owner
        nft.safeTransferFrom(address(this), msg.sender, _id);
        // Send the reward
        token.transfer(msg.sender, reward);
    }
}