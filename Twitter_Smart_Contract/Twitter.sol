// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";


interface IUser {

    struct UserProfile{
        string fullName;
        string bio;
    }

    function setProfile(address _address, string memory _FullName, string memory _Bio) external;
    function displayProfile(address _userAddress) external view returns(UserProfile memory);
}



contract Twitter is Ownable {
    IUser public user;

    constructor(address _contractAddress) Ownable(msg.sender){
        user = IUser(_contractAddress);
    }

     
    uint public MAX_TWEET_LENGTH = 280;

    struct Tweet{
        uint id;
        address author;
        string username;
        string content;                        
        uint timeStamp;
        uint likes;
    }

    mapping (address => Tweet[]) public TweetsArray;    

    
    modifier idExist(address author, uint _id){
        require(TweetsArray[author][_id].id == _id, "Tweet does not exist!!!");
        _;
    }

    modifier onlyRegistered(){
        string memory username = user.displayProfile(msg.sender).fullName;
        require(bytes(username).length > 0, "User does not exist");
        _;
    }
    
    
    event CreateTweetEvent(string indexed username, string tweetMessage);

    event LikedTweetEvent(address likedBy, address tweetAuthor, uint tweetId, string likedMessage, uint likeCount);

    event UnlikedTweetEvent(address unlikedBy, address tweetAuthor, uint tweetId, string unlikedMessage, uint likeCount);

    // 1.
    function createTweet(string memory _username, string memory _content) public onlyOwner onlyRegistered{
        require( bytes(_content).length <= 280, "Tweet message should be less than 280 characters!!!");

        Tweet memory TweetMsg = Tweet({
            // 'id' is nothing but the array length.
            id : TweetsArray[msg.sender].length,
            author : msg.sender,
            username : _username,
            content : _content,
            timeStamp : block.timestamp,
            likes : 0
        });
        TweetsArray[msg.sender].push(TweetMsg);
        emit CreateTweetEvent(TweetMsg.username, TweetMsg.content); 
        
    }

    // 2.
    function getTweetArray(address _owner) public view returns(Tweet[] memory){
        return (TweetsArray[_owner]);
    }   

    function changeTweetLength(uint _length) public onlyOwner{
        MAX_TWEET_LENGTH = _length;
    }

    // 3.
    function likeTweet(address author, uint _id) public idExist(author,_id) onlyRegistered{
        TweetsArray[author][_id].likes++;
        emit LikedTweetEvent(msg.sender, author, _id, TweetsArray[author][_id].content, TweetsArray[author][_id].likes);
    }

    function dislikeTweet(address author, uint _id) public idExist(author,_id) onlyRegistered{
        require(TweetsArray[author][_id].likes > 0, "Likes are already zero, you cannot decreament it!!!");
        TweetsArray[author][_id].likes--;

        emit UnlikedTweetEvent(msg.sender, author, _id, TweetsArray[author][_id].content, TweetsArray[author][_id].likes);
    }

    function getTotalLikes(address _user) public view returns(uint){
        uint totalLikes;

        for(uint i=0;i<TweetsArray[msg.sender].length;i++){
            totalLikes += TweetsArray[_user][i].likes;
        }

        return (totalLikes);
    }
}

contract SetData {
    uint public data;

    function setData(uint _data) public {
        data = _data;
    }
}