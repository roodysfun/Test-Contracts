pragma solidity ^0.5.12;

//We fix the problem by eliminating the declaration which overrides the prefered hardcap.

contract Tokensale {
    uint public hardcap = 10000 ether;

    // function Tokensale() {}
    constructor() public {}

    // function fetchCap() public view returns(uint) {
    //     return hardcap;
    // }
    
    function fetchCap() external view returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {
    //uint hardcap = 1000 ether;
    //If the hardcap variables were both needed we would have to rename one to fix this.
    constructor() public {
        hardcap = 1000 ether;
    }

}
