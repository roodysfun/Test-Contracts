pragma solidity ^0.4.19;

contract Tokensale {
    uint hardcap = 10000 ether;

    // function Tokensale() {}
    function Tokensale() public{}

    function fetchCap() public view returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {
    uint hardcap = 1000 ether;

    function Presale() public Tokensale() {}
}
