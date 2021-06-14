pragma solidity ^0.4.19;

contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {
        balances[msg.sender] = add(msg.value, balances[msg.sender]);
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] = add(_secondsToIncrease,lockTime[msg.sender]);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0);
        require(block.timestamp > lockTime[msg.sender]);

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        //(bool sent, ) = msg.sender.call.value(amount)("");
        require(msg.sender.call.value(amount)());
    }

	//from SafeMath
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      require(c >= a);

      return c;
    }
}

