pragma solidity 0.5.11;

contract Deployed {
    function setA(uint256) public returns (uint256) {}
    function a() public pure returns (uint256) {}
}

contract Existing {
    
    Deployed dc;
    
    constructor (address _dcAddress) public {
        dc = Deployed(_dcAddress);
    }
    
    function getA() public view returns (uint256 result) {
        return dc.a();
    }
    
    function setA(uint256 _val) public returns (uint256 result) {
        dc.setA(_val);
        return getA();
    }
}
