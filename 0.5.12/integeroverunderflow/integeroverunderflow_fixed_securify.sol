
contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) external {
    	require(_secondsToIncrease > 0);
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "Insufficient funds");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
		/*
        (bool sent, ) = msg.sender.call.value(amount)("");
        require(sent, "Failed to send Ether");
        */
    }
}

/*
Severity:    CRITICAL
Pattern:     Transaction Order Affects Ether Amount
Description: The amount of ether transferred must not be influenced by
             other transactions.
Type:        Violation
Contract:    TimeLock
Line:        22
Source: 
>         balances[msg.sender] = 0;
>         msg.sender.transfer(amount);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	/*


Severity:    CRITICAL
Pattern:     Transaction Order Affects Execution of Ether Transfer
Description: Ether transfers whose execution can be manipulated by
             other transactions must be inspected for unintended
             behavior.
Type:        Violation
Contract:    TimeLock
Line:        22
Source: 
>         balances[msg.sender] = 0;
>         msg.sender.transfer(amount);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	/*


Severity:    LOW
Pattern:     Usage of block timestamp
Description: Returned value relies on block timestamp.
Type:        Violation
Contract:    TimeLock
Line:        18
Source: 
>         require(balances[msg.sender] > 0, "Insufficient funds");
>         require(block.timestamp > lockTime[msg.sender], "Lock time not expired");
>                 ^^^^^^^^^^^^^^^
> 
*/