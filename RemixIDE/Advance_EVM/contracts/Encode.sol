// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Encode{

    // Encoding
    function encodeNumber() public pure returns (bytes memory){
        return abi.encode(1);
    }

    function encodeString() public pure returns (bytes memory){
        return abi.encode("Hello world!!!");
    }

    function encodeStringPacked() public pure returns (bytes memory){
        return abi.encodePacked("Hello world!!!");
    }

    function encodeStringConcat() public pure returns (string memory){
        return string(abi.encodePacked("Hello"," World"));
    }


    // Decoding
    function decodeString() public pure returns (string memory){
        return abi.decode(encodeString(), (string));
    }
    function decodeBytes() public pure returns (bytes memory){
        return abi.decode(encodeString(), (bytes));
    }

    function multiEncode() public pure returns (bytes memory){
        bytes memory str = abi.encode("Hello","World");
        return str; 
    }
    function multiDecode() public pure returns (string memory,string memory){
        (string memory str1,string memory str2) = abi.decode(multiEncode(), (string,string));
        return (str1,str2);
    }

}