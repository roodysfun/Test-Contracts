pragma solidity ^0.4.19;

contract Relayer {
    uint transactionId;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) transactions;

    function relay(Target target, bytes memory _data, uint _gasLimit) public {
        // replay protection; do not call the same transaction twice
        require(transactions[transactionId].executed == false);
        transactions[transactionId].data = _data;
        transactions[transactionId].executed = true;
        transactionId += 1;
        
        address(target).call("execute(bytes)", _data, _gasLimit);

    }
}

// Contract called by Relayer
contract Target {
    function execute(bytes memory _data, uint _gasLimit) public {
        require(msg.gas >= _gasLimit);
        // Execute contract code
    }
}
