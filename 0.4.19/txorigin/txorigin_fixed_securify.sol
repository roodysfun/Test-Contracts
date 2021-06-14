pragma solidity ^0.4.19;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract TxUserWallet {
    address owner;

    function TxUserWallet() public {
        owner = msg.sender;
    }

    function transferTo(address dest, uint amount) public {
        require(address(dest) != address(0));
	require(msg.sender == owner);
        require(amount >= 0);
        dest.transfer(amount);
    }
}
