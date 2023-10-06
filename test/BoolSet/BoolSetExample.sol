// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { BoolSetLib } from "src/BoolSet.sol";

contract BoolSetExample {
    using BoolSetLib for uint256;

    uint256 private boolSet;

    function getBool(uint8 index) external view returns(bool) {
        return boolSet.getBoolBit(index);
    }

    function setBool(uint8 index, bool value) external {
        boolSet = boolSet.setBoolBit(index, value);
    }

    function flipBool(uint8 index) external {
        boolSet = boolSet.flipBool(index);
    }
}