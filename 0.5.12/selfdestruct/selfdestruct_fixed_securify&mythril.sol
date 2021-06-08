

contract EtherGame {
    uint public constant targetAmount = 7 ether;
    uint public balance;
    address public winner;

    function deposit() external payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");
        balance += msg.value;
        require(balance <= targetAmount, "Game is over");
        if (balance >= targetAmount) {
           winner = msg.sender;
        }
    }
    

    function claimReward() external {
        require(msg.sender == winner, "Not winner");
        (bool sent, ) = msg.sender.call.value(address(this).balance)("");
        require(sent, "Failed to send Ether");
    }
}

/*
Severity:    INFO
Pattern:     Low Level Calls
Description: Usage of <address>.call should be avoided
Type:        Violation
Contract:    EtherGame
Line:        23
Source: 
> 
>         (bool sent, ) = msg.sender.call.value(address(this).balance)("");
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         require(sent, "Failed to send Ether");


Severity:    INFO
Pattern:     Solidity Naming Convention
Description: Reports declarations that do not adhere to Solidity's
             naming convention.
Type:        Violation
Contract:    EtherGame
Line:        4
Source: 
> contract EtherGame {
>     uint public constant targetAmount = 7 ether;
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     uint public balance;


Severity:    INFO
Pattern:     Solidity Naming Convention
Description: Reports declarations that do not adhere to Solidity's
             naming convention.
Type:        Violation
Contract:    EtherGame
Line:        23
Source: 
> 
>         (bool sent, ) = msg.sender.call.value(address(this).balance)("");
>          ^^^^^^^^^
>         require(sent, "Failed to send Ether");


Severity:    CRITICAL
Pattern:     Transaction Order Affects Ether Amount
Description: The amount of ether transferred must not be influenced by
             other transactions.
Type:        Violation
Contract:    EtherGame
Line:        23
Source: 
> 
>         (bool sent, ) = msg.sender.call.value(address(this).balance)("");
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         require(sent, "Failed to send Ether");


Severity:    CRITICAL
Pattern:     Transaction Order Affects Execution of Ether Transfer
Description: Ether transfers whose execution can be manipulated by
             other transactions must be inspected for unintended
             behavior.
Type:        Violation
Contract:    EtherGame
Line:        23
Source: 
> 
>         (bool sent, ) = msg.sender.call.value(address(this).balance)("");
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         require(sent, "Failed to send Ether");


Severity:    HIGH
Pattern:     Uninitialized State Variable
Description: State variables should be explicitly initialized.
Type:        Violation
Contract:    EtherGame
Line:        5
Source: 
>     uint public constant targetAmount = 7 ether;
>     uint public balance;
>     ^^^^^^^^^^^^^^^^^^^
>     address public winner;


Severity:    HIGH
Pattern:     Uninitialized State Variable
Description: State variables should be explicitly initialized.
Type:        Violation
Contract:    EtherGame
Line:        6
Source: 
>     uint public balance;
>     address public winner;
>     ^^^^^^^^^^^^^^^^^^^^^
> 


Severity:    CRITICAL
Pattern:     Unrestricted write to storage
Description: Contract fields that can be modified by any user must be
             inspected.
Type:        Violation
Contract:    EtherGame
Line:        11
Source: 
> 
>         balance += msg.value;
>         ^^^^^^^^^^^^^^^^^^^^
>         require(balance <= targetAmount, "Game is over");


Severity:    CRITICAL
Pattern:     Unrestricted write to storage
Description: Contract fields that can be modified by any user must be
             inspected.
Type:        Violation
Contract:    EtherGame
Line:        15
Source: 
>         if (balance >= targetAmount) {
>            winner = msg.sender;
>            ^^^^^^^^^^^^^^^^^^^
>         }
*/
