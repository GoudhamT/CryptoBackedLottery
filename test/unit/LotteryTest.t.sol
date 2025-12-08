//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {CryptoBackedLottery} from "../../src/CryptoBackedLottery.sol";

contract LotteryTest is Test {
    CryptoBackedLottery public backedLottery;
    uint256 public integerAmount;
    string public fractionAmount;

    function setUp() public {
        vm.startBroadcast();
        backedLottery = new CryptoBackedLottery(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        vm.stopBroadcast();
    }

    function testAmount() public {
        // (integerAmount, fractionAmount) = backedLottery.getPrice();
        console.log(integerAmount);
        console.log("fraction is ", fractionAmount);
    }
}
