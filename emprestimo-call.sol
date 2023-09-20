// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract EmprestimoCall {

    address public addTaxa = 0xEed2fE736e53E65412A3c3b8326260218bD40c16;

    function setTaxaComCall(uint256 _val) public returns (bytes memory) {
        (bool success, bytes memory data) = addTaxa.call(abi.encodeWithSignature("setTaxaBase(uint256)", _val));
        if(!success) {
            revert("function call has failed");
        }
        return (data);
    }
    
    function getTaxaViaCall() public returns (uint256) {
        (bool success, bytes memory data) = addTaxa.call(abi.encodeWithSignature("taxaBase()"));
        require(success, "function call has failed");        
        return abi.decode(data, (uint256));        
    }    
}
