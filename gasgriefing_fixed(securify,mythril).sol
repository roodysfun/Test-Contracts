pragma solidity ^0.5.12;

contract Relayer {
    uint private transactionId = 0;

    struct Tx {
        bytes data;
        bool executed;
    }

    mapping (uint => Tx) private transactions;

    function relay(Target target, bytes calldata _data, uint _gasLimit) external {
	require(address(target) != address(0), "Zero Address");
	require(_data.length >= 0, "Invalid data length");
	require(_gasLimit > 0, "Zero or Negative gas limit");

        // replay protection; do not call the same transaction twice
        require(transactions[transactionId].executed == false, 'same transaction twice');

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
	
	require(address(msg.sender) != address(0), "Zero Address");
	require(_data.length >= 0, "Invalid data length");
	require(_gasLimit > 0, "Zero or Negative gas limit");
        require(gasleft() >= _gasLimit, 'not enough gas');
        // Execute contract code
        (bool success,) = msg.sender.call.value(1)("");
        require(success, "Call relay failed");
    }
}
