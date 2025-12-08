//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract CryptoBackedLottery {
    using Strings for uint256;

    uint256 private constant USD_FOR_ETH = 5e18;
    address private immutable i_owner;

    AggregatorV3Interface public priceDataFeed;

    constructor(address _feed) {
        priceDataFeed = AggregatorV3Interface(_feed);
        i_owner = msg.sender;
    }

    function enterLottery() public payable {
        (
            uint256 weiAmount,
            uint256 integerPart,
            string memory fractionalString,
            string memory message
        ) = getPrice();
        if (weiAmount != msg.value) {
            revert();
        }
    }

    function getPrice()
        public
        view
        returns (
            uint256 weiAmount,
            uint256 integerPart,
            string memory fractionalString,
            string memory message
        )
    {
        (, int256 price, , , ) = priceDataFeed.latestRoundData();
        uint256 ethUsd = uint256(price);
        weiAmount = (USD_FOR_ETH * 1e8) / ethUsd;
        integerPart = weiAmount / 1e18;
        uint256 fractionalPart = weiAmount % 1e18;
        fractionalString = _pad18(fractionalPart);
        message = string(
            abi.encodePacked(
                "Send exactly ",
                Strings.toString(integerPart),
                ".",
                fractionalString,
                "ETH"
            )
        );
    }

    function _pad18(uint256 value) internal pure returns (string memory) {
        // pad fractional part to always 18 digits
        bytes memory buffer = new bytes(18);
        uint256 temp = value;

        // fill in reverse
        for (uint256 i = 18; i > 0; i--) {
            buffer[i - 1] = bytes1(uint8(48 + (temp % 10)));
            temp /= 10;
        }

        return string(buffer);
    }
}
