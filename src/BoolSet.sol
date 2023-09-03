// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library BoolSet {
    /**
    * @dev Returns a bool from a bool set at position `offset` from the right.
    */
    function getBoolBit(uint256 boolSet, uint8 offset) internal pure returns(bool result) {
        /// @solidity memory-safe-assembly
        assembly {
            result := and(shr(offset, boolSet),1)
        }
    }

    /**
    * @dev Sets a bool value to a bool set at position `offset` from the right.
    */
    function setBoolBit(uint256 boolSet, uint8 offset, bool value) internal pure returns(uint256 result) {
        /// @solidity memory-safe-assembly
        assembly {
            switch value
            case 1 { // value is 1
                result := or(boolSet, shl(offset, value))
            }
            default { // value is 0
                result := and(boolSet, not(shl(offset, 1)))
            }
        }
    }

    /**
    * @dev Flips the bool value at position `offset` from the right.
    */
    function flipBool(uint256 boolSet, uint8 offset) internal pure returns(uint256 result) {
        /// @solidity memory-safe-assembly
        assembly {
            result := xor(boolSet, shl(offset, 1))
        }
    }
}
