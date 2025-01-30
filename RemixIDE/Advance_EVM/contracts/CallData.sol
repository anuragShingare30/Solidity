// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CallData{
    address public s_address;
    uint256 public s_amount;

    function transfer(address _address, uint256 _amount) public {
        s_address = _address;
        s_amount = _amount;
    }   

    function getSelector() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    /** 
        * getDataToCallTransfer() gets the data(function name and arguments) to be called directly
    */
    function getDataToCallTransfer(address _address, uint256 _amount) public pure returns(bytes memory){
        return abi.encodeWithSelector(getSelector(), _address,_amount);
    }

    /** 
        * callTransferData() calls the transfer function with the help of bytes directly.
    */
    function callTransferData(address _address, uint256 _amount) public returns (bytes4 ,bool) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSelector(getSelector(), _address,_amount)
        );
        return (bytes4(data), success);
    }


    function callTransferDataSig(address _address, uint256 _amount) public returns (bytes4 ,bool) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSignature("transfer(address,uint256)", _address,_amount)
        );
        return (bytes4(data), success);
    }

    
}   