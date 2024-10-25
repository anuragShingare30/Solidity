// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleTryCatch {

    function tryCatch() public pure {
        require(false,"Error Occurred!!!");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason); 
    event ErrorLoggingCode(uint errorcode);

    function handlingError() public {
        ExampleTryCatch test = new  ExampleTryCatch();

        try test.tryCatch(){
            // do something
        }
        catch Error(string memory reason){
            emit ErrorLogging(reason);
        }
        // Panic is for assert (optional)
        catch Panic(uint errorcode){
            emit ErrorLoggingCode(errorcode);
        }
    }
}