// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract SocialNetwork{
    string public name;
    uint public postCount = 0;
    struct Post{
        uint id;
        string content;
        uint tipAmount;
        address payable author;    
    }
    mapping(uint => Post) public posts;
    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );
    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    constructor() public {
        name="Naman's Decentralised Social Network";
    }

    function createPost(string memory _content) public { 
        // Require valid content
        require(bytes(_content).length > 0); 
        // Increment post count
        postCount ++;
        // Create the post
        posts[postCount] = Post(postCount,_content,0,msg.sender);
        // Trigger the event
        emit PostCreated(postCount,_content,0,msg.sender);

    }

    function tipPost(uint _id) public payable{
        require(_id > 0 && _id <= postCount);
        // fetch the post
        Post memory post = posts[_id];
        // fetch the author
        address payable _author = post.author;
        // pay the author
        address(_author).transfer(msg.value);
        // increment the tip
        post.tipAmount = post.tipAmount + msg.value;
        // update the post
        posts[_id]=post;
        // trigger an event
        emit PostTipped(postCount,post.content,post.tipAmount,_author);

    }

}




















