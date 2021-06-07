pragma solidity ^0.5.12;


contract KingOfEther {
    address public king = msg.sender;
    uint public balance = 0;

    mapping(address => uint) public balances;


    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");

        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    function withdraw(uint amount) public {     
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        msg.sender.transfer(amount);    

    }

}

