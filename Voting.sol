pragma solidity ^0.4.18;

contract Voting {
  enum VoteStates {Absent, Yes, No}
  event VoteCreated(uint256 pollNumber);
  event VoteCast(uint256 voteNumber);
  Vote[] public votes;
  struct Vote {
    address creator;
    string question;
    uint256 yes;
    uint256 no;
    mapping (address => VoteStates) voterStates;
  }
  function newVote(string _question) external {
    votes.push(Vote(msg.sender, _question, 0, 0));
    VoteCreated(votes.length-1);
  }
  function castVote(uint256 _id, bool _vote) public {
    Vote storage thisVote = votes[_id];
    VoteStates state = thisVote.voterStates[msg.sender];
    if (_vote == true && state == VoteStates.Absent) {
      thisVote.yes++;
      thisVote.voterStates[msg.sender] = VoteStates.Yes;
      VoteCast(_id);
    }
    else if (_vote == true && state == VoteStates.No) {
      thisVote.yes++;
      thisVote.no--;
      thisVote.voterStates[msg.sender] = VoteStates.Yes;
      VoteCast(_id);
    }
    else if (_vote == false && state == VoteStates.Absent) {
      thisVote.no++;
      thisVote.voterStates[msg.sender] = VoteStates.No;
      VoteCast(_id);
    }
    else if (_vote == false && state == VoteStates.Yes) {
      thisVote.yes--;
      thisVote.no++;
      thisVote.voterStates[msg.sender] = VoteStates.No;
      VoteCast(_id);
    }
    else if (_vote == true && state == VoteStates.Yes) {
      thisVote.voterStates[msg.sender] = VoteStates.Yes;
      VoteCast(_id);
    }
    else if (_vote == false && state == VoteStates.No) {
      thisVote.voterStates[msg.sender] = VoteStates.No;
      VoteCast(_id);
    }
  }
}
