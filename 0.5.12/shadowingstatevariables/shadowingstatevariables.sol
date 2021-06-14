pragma solidity ^0.5.12;

contract Tokensale {
    uint hardcap = 10000 ether;

    // function Tokensale() {}
    constructor() public {}

    function fetchCap() public view returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {
    uint hardcap = 1000 ether;
    //function Presale() Tokensale() {}
    constructor() public {}
}
