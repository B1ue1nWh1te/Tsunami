// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract Multiplier2Exp is Test {
    address Exploiter = address(this);

    function setUp() public {
        vm.createSelectFork("eth", 21257792 - 1);
        vm.label(Exploiter, "Exploiter");
        deal(Exploiter, 1 ether);
    }

    function testExploit() public {
        emit log_named_decimal_uint("[Before Exploit][Exploiter]ETH balance", address(Exploiter).balance, 18);
        console.log("----------------------------------------");
        console.log("----------------------------------------");
        emit log_named_decimal_uint("[After Exploit][Exploiter]ETH balance", address(Exploiter).balance, 18);
    }
}
