
// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract Fund {
    /// Mapping of ether shares of the contract.
    mapping(address => uint) public shares;
    /// Withdraw your share.
    function withdraw() check external {
        //if (msg.sender.send(shares[msg.sender]))
        uint share = shares[msg.sender];
        shares[msg.sender] = 0;
        msg.sender.transfer(share);
    }
    
    modifier check() {
    	require(shares[msg.sender] > 0);
    	_;
    }
}

/*
Severity:    CRITICAL
Pattern:     Transaction Order Affects Ether Amount
Description: The amount of ether transferred must not be influenced by
             other transactions.
Type:        Violation
Contract:    Fund
Line:        11
Source: 
>         shares[msg.sender] = 0;
>         msg.sender.transfer(share);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>     }


Severity:    CRITICAL
Pattern:     Transaction Order Affects Execution of Ether Transfer
Description: Ether transfers whose execution can be manipulated by
             other transactions must be inspected for unintended
             behavior.
Type:        Violation
Contract:    Fund
Line:        11
Source: 
>         shares[msg.sender] = 0;
>         msg.sender.transfer(share);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>     }
*/
