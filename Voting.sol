pragma solidity ^0.4.18;

contract Voting {
  Vote[] public votes;
  struct Vote {
    address creator;
    string question;
    uint256 yes;
    uint256 no;
  }
  function newVote(string _question) external {
    votes.push(Vote(msg.sender, _question, 0, 0));
  }
  function castVote(uint256 _id, bool _vote) {
    Vote storage thisVote = votes[_id];
    if (_vote == true) {
      thisVote.yes++;
    }
    if (_vote == false) {
      thisVote.no++;
    }  
  }
}
