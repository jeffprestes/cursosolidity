/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
Example to show how to use create (or personal) a library
*/
pragma solidity 0.7.4;

library Count {
    
    struct Hold {
        uint a;
    }
    
    function subUint(Hold storage s, uint b) public view returns (uint) {
        require(s.a >= b);
        return s.a-b;
    }
    
    function addUint(uint a, uint b) public pure returns (uint) {
        uint c = a+b;
        require(c>=a);
        return c;
    }
}