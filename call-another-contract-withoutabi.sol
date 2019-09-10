pragma solidity 0.5.11;

contract ExistingWithoutAbi {
    
    address dc;
    
    constructor (address _dcAddress) public {
        dc = _dcAddress;
    }
    
    function setA(uint256 _val) public returns (bytes memory) {
        (bool success, bytes memory data) = dc.call(abi.encodeWithSignature("setA(uint256)", _val));
        require(success, "function call has failed");
        return (data);
    }
    
    function getA() public returns (uint256) {
        (bool success, bytes memory data) = dc.call(abi.encodeWithSignature("a()"));
        require(success, "function call has failed");
        return bytesToUint(data);
    }
    
    function bytesToUint(bytes memory b) public pure returns (uint256){
        uint256 number;
        for(uint i=0;i<b.length;i++){
            number = number + uint(uint8(b[i]))*(2**(8*(b.length-(i+1))));
        }
        return number;
    }
    
}
