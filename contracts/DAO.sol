// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract DAO {

    IERC20 public token;
    uint256 public quorum = 1000;

    struct Proposal {
        string description;
        uint256 voteCount;
        uint256 deadline;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(uint256 => mapping(address => bool)) public voted;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function createProposal(string memory _description) external {
        proposals.push(
            Proposal({
                description: _description,
                voteCount: 0,
                deadline: block.timestamp + 3 days,
                executed: false
            })
        );
    }

    function vote(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];

        require(block.timestamp < proposal.deadline, "Voting closed");
        require(!voted[proposalId][msg.sender], "Already voted");

        uint256 votingPower = token.balanceOf(msg.sender);
        proposal.voteCount += votingPower;
        voted[proposalId][msg.sender] = true;
    }
}
