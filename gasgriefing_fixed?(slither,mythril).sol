pragma solidity ^0.5.12;

contract Relayer {
    uint transactionId;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) transactions;

    function relay(Target target, bytes calldata _data, uint _gasLimit) external {
        // replay protection; do not call the same transaction twice
        require(!transactions[transactionId].executed, 'same transaction twice');
        transactions[transactionId].data = _data;
        transactions[transactionId].executed = true;
        transactionId += 1;
        (bool success,) = address(target).call(abi.encodeWithSignature("execute(bytes)", _data, _gasLimit));
        require(success, "Call relay failed");
    }
}

// Contract called by Relayer
contract Target {
    function execute(bytes calldata _data, uint _gasLimit) external {
        require(gasleft() >= _gasLimit, 'not enough gas');
        // Execute contract code
    }
}
