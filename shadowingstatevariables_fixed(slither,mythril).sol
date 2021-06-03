pragma solidity ^0.5.12;

contract Tokensale {
    uint public hardcap = 10000 ether;

    // function Tokensale() {}
    constructor() public {}

    function fetchCap() external view returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {

    //function Presale() Tokensale() {}
    constructor() public {
		hardcap = 1000 ether;
	}
}

