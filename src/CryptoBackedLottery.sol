//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract CryptoBackedLottery {
    using Strings for uint256;

    function getPrice()
        public
        pure
        returns (uint256 integerPart, string memory fractionalString)
    {
        uint256 usd = 5e18;
        uint256 ethUsd = 200000000000;
        uint256 weiAmount = (usd * 1e8) / ethUsd;
        integerPart = weiAmount / 1e18;
        uint256 fractionalPart = weiAmount % 1e18;
        fractionalString = _pad18(fractionalPart);
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
