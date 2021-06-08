pragma solidity ^0.4.19;

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether);
        uint balance = address(this).balance;
        require(balance <= targetAmount);
        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner);
        //(bool sent, ) = msg.sender.call.value(address(this).balance)("");
        require(msg.sender.call.value(address(this).balance)());
    }
}

