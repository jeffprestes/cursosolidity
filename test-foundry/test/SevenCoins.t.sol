// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/SevenCoins.sol";

contract SevenCoinTest is Test {

  SevenCoins public sevenCoins;
  address public userTest;

  function setUp() public {
    sevenCoins = new SevenCoins();
    userTest = address(0x2E69508520ed70Bd227bcb8fa68865F1F0756c12);
  }

  function testTransfer() public {
    sevenCoins.transfer(userTest, 100000);
    assertEq(100000, sevenCoins.balanceOf(userTest));
  }

}