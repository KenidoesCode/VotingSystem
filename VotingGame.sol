// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingGame{
    address public admin;

    constructor(){
    admin=msg.sender;
}

struct Proposal{
    string name;
    uint VoteCount;

}

Proposal[] public proposals;

mapping(address => bool) public hasVoted;

function addProposal(string memory _name)public{
    require(msg.sender==admin,"Only the admin can add proposals");
    proposals.push(Proposal(_name,0));
}

function vote(uint index)public{
    require(!hasVoted[msg.sender],"Already voted");
    require(index < proposals.length,"Invaild Proposal");
    
    proposals[index].VoteCount+=1;
    hasVoted[msg.sender]=true;
}

function getWinningProposal() public view returns(string memory){
    uint WinningVotes=0;
    uint winnerIndex=0;

    for(uint i=0;i<proposals.length;i++){
        if(proposals[i].VoteCount > WinningVotes){
            WinningVotes=proposals[i].VoteCount;
            winnerIndex=i;
        }
    } 
    return proposals[winnerIndex].name;
}
}

