pragma solidity ^0.5.12;

contract EtherGame {
    uint public constant TARGET_AMOUNT = 7 ether;
    address public winner;

    function deposit() external payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        uint balance = address(this).balance;
        require(balance <= TARGET_AMOUNT, "Game is over");

        if (balance >= TARGET_AMOUNT) {
            winner = msg.sender;
        }
    }

    function claimReward() external {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call.value(address(this).balance)("");
        require(sent, "Failed to send Ether");
    }
}

