// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SampleStruct {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct StudentReport {
        string name;
        uint256 mark1;
        uint256 mark2;
        string HomeAdd;
    }

    StudentReport[] public ReportArray;

    function fillReport(
        string memory _name,
        uint256 mark1,
        uint256 mark2,
        string memory _address
    ) public {

        // string memory text;
        StudentReport memory ReportCard = StudentReport({
            name: _name,
            mark1: mark1,
            mark2: mark2,
            HomeAdd: _address
        });

        ReportArray.push(ReportCard);
    }

    function getReportCard() public view returns (StudentReport[] memory) {
        return (ReportArray);
    }
}
