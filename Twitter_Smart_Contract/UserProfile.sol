// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile {

    struct UserProfile{
        string fullName;
        string bio;
    }

    mapping (address => UserProfile) public profile;

    function setProfile(string memory _FullName, string memory _Bio) public {
        UserProfile memory newProfile = UserProfile({
            fullName:_FullName,
            bio : _Bio
        });

        profile[msg.sender] = newProfile;
    }

    function displayProfile(address _userAddress) public view returns(UserProfile memory){
        return profile[_userAddress];
    }

    receive() external payable { }
}