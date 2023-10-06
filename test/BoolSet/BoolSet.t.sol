// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {BoolSetExample} from "./BoolSetExample.sol";

contract CounterTest is Test {
    BoolSetExample public bse;

    function setUp() public {
        bse = new BoolSetExample();
    }

    function test_SetAndFlipBool() public {
        assertEq(bse.getBool(49), false);
        bse.setBool(49, true);
        assertEq(bse.getBool(49), true);
        bse.setBool(49, false);
        assertEq(bse.getBool(49), false);
        
        assertEq(bse.getBool(255), false);
        bse.setBool(255, true);
        assertEq(bse.getBool(255), true);
        bse.flipBool(255);
        assertEq(bse.getBool(255), false);
        bse.flipBool(255);
        assertEq(bse.getBool(255), true);
    }

    function test_SetBoolFuzz(uint8 index, bool value) public {
        bse.setBool(index, value);
        assertEq(bse.getBool(index), value);
    }

    function test_FlipBoolFuzz(uint8 index) public {
        bool valueBefore = bse.getBool(index);
        bse.flipBool(index);
        assertEq(!valueBefore, bse.getBool(index)); // The value should be flipped
    }
}
