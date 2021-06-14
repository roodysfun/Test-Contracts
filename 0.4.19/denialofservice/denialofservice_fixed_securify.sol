pragma solidity ^0.4.19;

contract KingOfEther {

    address public king;

    uint public balance;

    mapping(address => uint) public balances;

    function claimThrone() external payable {

        require(msg.value > balance);

        balances[king] += balance;

        balance = msg.value;

        king = msg.sender;

    }
    
    function withdraw() public {
        require(msg.sender != king);

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        require(msg.sender.call.value(amount)());
    }

}
