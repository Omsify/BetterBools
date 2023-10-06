// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test, console2 } from "forge-std/Test.sol";
import { LogicalMatrix, LogicalMatrixLib } from "src/LogicalMatrix.sol";

contract CounterTest is Test {
    using LogicalMatrixLib for LogicalMatrix;

    LogicalMatrix private lm;

    function setUp() public {
        // Set up lm for unit tests
        /*
        * 11011
        * 01010
        * 11110
        */
        // Bool set equivalent to table above
        uint256 boolSet = 0xdabc000000000000000000000000000000000000000000000000000000000000;
        uint256[] memory boolSets = new uint256[](1);
        boolSets[0] = boolSet;

        lm = LogicalMatrix(5,3, boolSets);
    }
    
    function testLMValues() external {
        assertEq(lm.getBoolByColumnAndIndex(0, 0), true);
        assertEq(lm.getBoolByColumnAndIndex(0, 1), false);
        assertEq(lm.getBoolByColumnAndIndex(0, 2), true);
        assertEq(lm.getBoolByColumnAndIndex(1, 0), true);
        assertEq(lm.getBoolByColumnAndIndex(1, 1), true);
        assertEq(lm.getBoolByColumnAndIndex(1, 2), true);
        assertEq(lm.getBoolByColumnAndIndex(2, 0), false);
        assertEq(lm.getBoolByColumnAndIndex(2, 1), false);
        assertEq(lm.getBoolByColumnAndIndex(2, 2), true);
        assertEq(lm.getBoolByColumnAndIndex(3, 0), true);
        assertEq(lm.getBoolByColumnAndIndex(3, 1), true);
        assertEq(lm.getBoolByColumnAndIndex(3, 2), true);
        assertEq(lm.getBoolByColumnAndIndex(4, 0), true);
        assertEq(lm.getBoolByColumnAndIndex(4, 1), false);
        assertEq(lm.getBoolByColumnAndIndex(4, 2), false);

        assertEq(lm.getBoolByRowAndIndex(0, 0), true);
        assertEq(lm.getBoolByRowAndIndex(0, 1), true);
        assertEq(lm.getBoolByRowAndIndex(0, 2), false);
        assertEq(lm.getBoolByRowAndIndex(0, 3), true);
        assertEq(lm.getBoolByRowAndIndex(0, 4), true);
        assertEq(lm.getBoolByRowAndIndex(1, 0), false);
        assertEq(lm.getBoolByRowAndIndex(1, 1), true);
        assertEq(lm.getBoolByRowAndIndex(1, 2), false);
        assertEq(lm.getBoolByRowAndIndex(1, 3), true);
        assertEq(lm.getBoolByRowAndIndex(1, 4), false);
        assertEq(lm.getBoolByRowAndIndex(2, 0), true);
        assertEq(lm.getBoolByRowAndIndex(2, 1), true);
        assertEq(lm.getBoolByRowAndIndex(2, 2), true);
        assertEq(lm.getBoolByRowAndIndex(2, 3), true);
        assertEq(lm.getBoolByRowAndIndex(2, 4), false);
    }

    function test_SetLMValuesByRowFuzz(uint256 row, uint256 index, bool value) external {
        vm.assume(row < lm.ySize);
        vm.assume(index < lm.xSize);

        lm.setBoolByRowAndIndex(row, index, value);
        assertEq(lm.getBoolByRowAndIndex(row, index), value);
    }

    function test_SetLMValuesByColumnFuzz(uint256 column, uint256 index, bool value) external {
        vm.assume(column < lm.xSize);
        vm.assume(index < lm.ySize);

        lm.setBoolByColumnAndIndex(column, index, value);
        assertEq(lm.getBoolByColumnAndIndex(column, index), value);
    }
}
