pragma solidity ^0.5.12;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract TxUserWallet {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    
    function transferTo(address payable dest, uint amount) external {
        require(msg.sender == owner, "You are not the owner");
		require(address(dest) != address(0));  
        (bool sent, ) = dest.call.value(amount)("");
        require(sent, "Failed to send Ether");
    }

}
