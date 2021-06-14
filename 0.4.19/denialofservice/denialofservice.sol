pragma solidity ^0.4.19;

contract KingOfEther {
    address public king;
    uint public balance;

    function claimThrone() external payable {
        require(msg.value > balance);
        require(king.call.value(balance)());
        balance = msg.value;
        king = msg.sender;
    }
}

