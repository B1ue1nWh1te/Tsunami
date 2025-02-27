// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

abstract contract TemplateForPoC is Test {
    address _exploiter;

    modifier logETHBalanceChanges() {
        console.log("[Exploiter]:", _exploiter);
        uint256 balanceBefore = _exploiter.balance;
        emit log_named_decimal_uint("[Before][Exploiter][ETH]:", balanceBefore, 18);
        console.log("----------------------------------------");
        console.log("[Exploiting...]");
        _;
        console.log("----------------------------------------");
        uint256 balanceAfter = _exploiter.balance;
        emit log_named_decimal_uint("[After][Exploiter][ETH]:", balanceAfter, 18);
        emit log_named_decimal_uint("[Changed][Exploiter][ETH]:", (balanceAfter - balanceBefore), 18);
    }

    function setUp() public virtual {}

    function testExploit() public virtual logETHBalanceChanges {}
}
