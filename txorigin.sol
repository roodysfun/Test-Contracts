pragma solidity ^0.5.12;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract TxUserWallet {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function transferTo(address payable dest, uint amount) public {
        require(msg.sender == owner);
        dest.transfer(amount);
    }
}
