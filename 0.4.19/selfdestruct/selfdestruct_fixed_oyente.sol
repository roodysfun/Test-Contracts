pragma solidity ^0.4.19;

contract EtherGame {
    uint public targetAmount = 7 ether;
	uint public balance;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether);
        
		balance += msg.value;
        require(balance <= targetAmount);
        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
		uint temp_bal = balance;
		balance = 0;
        require(msg.sender == winner);
        require(msg.sender.call.value(temp_bal)());
    }
}



