pragma solidity ^0.5.12;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract TxUserWallet {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function transferTo(address payable dest, uint amount) external {
        require(address(dest) != address(0));
	require(amount >= 0);
    	require(msg.sender == owner);
        dest.transfer(amount);
    }
}
