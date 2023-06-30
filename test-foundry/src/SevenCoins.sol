// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

/*
forge init
forge build
forge test
forge create SevenCoins --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY --legacy
Deployed to: 0x2342EFC0B0C19F74B1Fab202704c49780D43DEd4
forge verify-contract --compiler-version v0.8.19+commit.7dd6d404 --verifier-url=https://api-testnet.polygonscan.com/api/ 0x2342EFC0B0C19F74B1Fab202704c49780D43DEd4 SevenCoins $POLYGONSCAN_API_KEY
cast call --rpc-url=$RPC_URL 0x2342EFC0B0C19F74B1Fab202704c49780D43DEd4 "totalSupply()(uint256)"
cast send --rpc-url=$RPC_URL  --private-key=$PRIVATE_KEY 0x2342EFC0B0C19F74B1Fab202704c49780D43DEd4  "transfer(address,uint256)" 0x263C3Ab7E4832eDF623fBdD66ACee71c028Ff591 100000001
cast call --rpc-url=$RPC_URL 0x2342EFC0B0C19F74B1Fab202704c49780D43DEd4 "balanceOf(address)(uint256)" 0x263C3Ab7E4832eDF623fBdD66ACee71c028Ff591 
*/

contract SevenCoins is ERC20, ERC20Burnable, Pausable, Ownable, ERC20Permit {
    constructor() ERC20("SevenCoins", "7COIN") ERC20Permit("SevenCoins") {
        _mint(msg.sender, 100000000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}