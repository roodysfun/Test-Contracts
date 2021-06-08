pragma solidity ^0.4.19;

contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0);
        require(block.timestamp > lockTime[msg.sender]);

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        //(bool sent, ) = msg.sender.call.value(amount)("");
        require(msg.sender.call.value(amount)());
    }
}

