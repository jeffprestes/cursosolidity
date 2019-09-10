pragma solidity 0.5.11;

contract Deployed {
    uint256 public a = 1;
    
    function setA(uint256 _a) public returns (uint256) {
        a = _a;
        return a;
    }
}
