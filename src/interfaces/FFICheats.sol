// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface FFICheats {
    function ffi(string[] calldata) external returns (bytes memory);
}
