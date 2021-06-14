pragma solidity ^0.4.19;

contract Relayer {
    uint transactionId;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) transactions;

    function relay(Target target, bytes memory _data) public returns(bool) {
        // replay protection; do not call the same transaction twice
        require(transactions[transactionId].executed == false);
        transactions[transactionId].data = _data;
        transactions[transactionId].executed = true;
        transactionId += 1;
        bool success  = address(target).call("execute(bytes)", _data);
        return success;
    }
}

// Contract called by Relayer
contract Target {
    function execute(bytes memory _data) public {
        // Execute contract code
    }
}
