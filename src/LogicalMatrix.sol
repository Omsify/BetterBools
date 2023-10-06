// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BoolSet} from "./BoolSet.sol";

/*
* 11011
* 01010
* 11110
* Equals to xSize: 5, ySize: 3
*/
struct LogicalMatrix {
    uint256 xSize;
    uint256 ySize;
    uint256[] boolSets;
}

library LogicalMatrixLib {
    using BoolSet for uint256;

    /// @param index is index of a bool in the row `row` from the left.
    function getBoolByRowAndIndex(LogicalMatrix storage matrix, uint256 row, uint256 index) internal view returns (bool) {
        (uint256 boolSetIndex, uint8 indexInBoolSet) = getMatrixIndicesByRowAndIndex(matrix.xSize, row, index);
        return matrix.boolSets[boolSetIndex].getBoolBit(indexInBoolSet);
    }

    /// @param index is index of a bool in the column `column` from the top.
    function getBoolByColumnAndIndex(LogicalMatrix storage matrix, uint256 column, uint256 index) internal view returns (bool) {
        (uint256 boolSetIndex, uint8 indexInBoolSet) = getMatrixIndicesByColumnAndIndex(matrix.xSize, column, index);
        return matrix.boolSets[boolSetIndex].getBoolBit(indexInBoolSet);
    }

    /// @param index is index of a bool in the row `row` from the left.
    function setBoolByRowAndIndex(LogicalMatrix storage matrix, uint256 row, uint256 index, bool value) internal {
        (uint256 boolSetIndex, uint8 indexInBoolSet) = getMatrixIndicesByRowAndIndex(matrix.xSize, row, index);
        uint256 boolSet = matrix.boolSets[boolSetIndex];
        matrix.boolSets[boolSetIndex] = boolSet.setBoolBit(indexInBoolSet, value);
    }

    /// @param index is index of a bool in the column `column` from the top.
    function setBoolByColumnAndIndex(LogicalMatrix storage matrix, uint256 column, uint256 index, bool value) internal {
        (uint256 boolSetIndex, uint8 indexInBoolSet) = getMatrixIndicesByColumnAndIndex(matrix.xSize, column, index);
        uint256 boolSet = matrix.boolSets[boolSetIndex];
        matrix.boolSets[boolSetIndex] = boolSet.setBoolBit(indexInBoolSet, value);
    }

    ////////////////////////////
    ///// Helper Functions /////
    ////////////////////////////

    function getMatrixIndicesByRowAndIndex(uint256 xSize, uint256 row, uint256 index) private pure returns(uint256 boolSetIndex, uint8 indexInBoolSet) {
        uint256 bitsBefore = row * xSize + index;

        boolSetIndex = bitsBefore / 256; // 256 bools in one boolSet
        indexInBoolSet = 255 - uint8(bitsBefore % 256);
    }

    function getMatrixIndicesByColumnAndIndex(uint256 xSize, uint256 column, uint256 index) private pure returns(uint256 boolSetIndex, uint8 indexInBoolSet) {
        uint256 bitsBefore = index * xSize + column;

        boolSetIndex = bitsBefore / 256; // 256 bools in one boolSet
        indexInBoolSet = 255 - uint8(bitsBefore % 256);
    }
}
