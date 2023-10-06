# BetterBools
Libraries to interact with booleans more efficiently in Solidity.

Currently, there are two libraries implemented:
- BoolSetLib allows packing 256 booleans into one uint256 variable. It is useful to save a lot of gas on storage slots. Solidity stores just 32 booleans in one slot, so this library increases this number 8 times.
- LogicalMatrix allows convenient usage of huge boolean value tables (logical matrices).

## Installation
```bash
forge install Omsify/BetterBools
```

### Suggestions and contributions are welcome!