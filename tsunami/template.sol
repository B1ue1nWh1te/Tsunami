// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {IERC20, IBalancerFlashLoan, IBalancerFlashLoanRecipient} from "tsunami/utils.sol";

contract TemplateExp is Test, IBalancerFlashLoanRecipient {
    address Exploiter = address(this);

    function setUp() public {
        vm.createSelectFork("eth");
        vm.label(Exploiter, "Exploiter");
        deal(Exploiter, 1 ether);
    }

    function testExploit() public {
        emit log_named_decimal_uint("[Before Exploit][Exploiter]ETH Balance:", address(Exploiter).balance, 18);
        console.log("----------------------------------------");
        console.log("[Exploiting...]");
        console.log("----------------------------------------");
        emit log_named_decimal_uint("[After Exploit][Exploiter]ETH Balance:", address(Exploiter).balance, 18);
    }

    function receiveFlashLoan(
        IERC20[] memory tokens,
        uint256[] memory amounts,
        uint256[] memory feeAmounts,
        bytes memory userData
    ) external {}
}
