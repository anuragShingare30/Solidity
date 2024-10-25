// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SampleArray {
    uint[] public dynamicArray;

    function setValue(uint value) public {
        dynamicArray.push(value);
    }

    function getValue(uint index) public view returns (uint){
        return dynamicArray[index];
    }

    function deleteElement() public {
        dynamicArray.pop();
    }

    function sizeOfArray() public view  returns (uint){
        return dynamicArray.length;
    }
}