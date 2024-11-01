// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;


import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/exo-digital-labs/ERC721R/blob/main/contracts/ERC721A.sol";
import "https://github.com/exo-digital-labs/ERC721R/blob/main/contracts/IERC721R.sol";

contract Web3 is ERC721A, Ownable {
    uint public constant publicPrice = 1 ether;
    uint public constant maxMintPerUser = 2;
    uint public constant maxNFTMinting = 5;
    uint public constant refundPeriod = 3 minutes;
    uint public refundEndTimeStamp;

    address public refundAddress;

    mapping(uint => uint) public refundEndTimeStamps;
    mapping (uint => bool) public hasRefunded;


    constructor()
        ERC721A("Web3", "MTK")
        Ownable(msg.sender)
    {
        refundAddress = address(this);
        refundEndTimeStamp = block.timestamp + refundPeriod;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmbseRTJWSsLfhsiWwuB2R7EtN93TxfoaMz1S5FXtsFEUB/";
    }

    function publicMint(uint256 amount) public payable  {
        require(msg.value == (publicPrice * amount),"NOT ENOUGH MONEY!!!");
        // returns the number of tokens minted by 'owner'
        require(_numberMinted(msg.sender) + amount < maxMintPerUser, "SORRY LIMIT REACHED FOR MINTING NFTs!!!");
        // returns the total amount of tokens minted in the contract
        require(_totalMinted() <= maxNFTMinting, "WE SOLD OUT!!!");
        _safeMint(msg.sender, amount);

        refundEndTimeStamp = block.timestamp + refundPeriod;
        for(uint i = _currentIndex - amount; i<_currentIndex; i++){
            refundEndTimeStamps[i] = refundEndTimeStamp;
        }
    }

    function refund(uint tokenId) external payable {
        // check token expiry time stamp
        require(getTokenTimeStamp(tokenId) > block.timestamp, "REFUND PERIOD EXPIRED!!!");
        // you should be the owner of tokenid
        require(msg.sender == ownerOf(tokenId), "YOU ARE NOT THE OWNER OF THIS TOKEN");

        // mark the refund
        hasRefunded[tokenId] = true;

        // Transfer Ownership of nft
        _transfer(msg.sender, refundAddress, tokenId);

        // refund the price
        uint refundAmount = getRefundAmount(tokenId);
        payable(msg.sender).transfer(refundAmount);
    }   

    function getRefundAmount(uint tokenId) public view returns (uint){
        if(hasRefunded[tokenId]){
            return 0;
        }
        return publicPrice;
    }

    function getTokenTimeStamp(uint tokenId) public view returns(uint){
        if(hasRefunded[tokenId]){
            return 0;
        }
        return refundEndTimeStamps[tokenId];
    }

    function withDrawMoney(address _address) external payable {
        require(refundEndTimeStamp < block.timestamp, "YOU CANNOT WITHDRAW MONEY WHEN WITHDRAW PERIOD IS ON");
        uint balance = address(this).balance;
        payable(_address).transfer(balance);
    }   
}
