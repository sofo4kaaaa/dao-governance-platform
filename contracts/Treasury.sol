// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Treasury {

    address public dao;

    constructor(address _dao) {
        dao = _dao;
    }

    receive() external payable {}

    function executePayment(address payable recipient, uint256 amount) external {
        require(msg.sender == dao, "Only DAO can execute");
        recipient.transfer(amount);
    }
}
