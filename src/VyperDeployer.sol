// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./interfaces/FFICheats.sol";

contract VyperDeployer is Test {
    FFICheats cheatCodes = FFICheats(HEVM_ADDRESS);

    function compileVyper(string memory fileLocation)
        public
        returns (bytes memory)
    {
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = fileLocation;

        bytes memory bytecode = cheatCodes.ffi(cmds);
        return bytecode;
    }

    function compileVyper(string memory fileLocation, bytes calldata args)
        public
        returns (bytes memory)
    {
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = fileLocation;

        bytes memory bytecode = cheatCodes.ffi(cmds);
        bytes memory bytecodeWithArgs = abi.encodePacked(bytecode, args);
        return bytecodeWithArgs;
    }

    function deployByteCode(bytes memory vyperFileByteCode)
        public
        returns (address)
    {
        address deployedAddress;
        assembly {
            deployedAddress := create(
                0,
                add(vyperFileByteCode, 0x20),
                mload(vyperFileByteCode)
            )
        }
        require(
            deployedAddress != address(0),
            "VyperDeployer could not deploy contract"
        );
        return deployedAddress;
    }

    function deployContract(string memory fileLocation)
        public
        returns (address)
    {
        bytes memory vyperFileByteCode = compileVyper(fileLocation);
        address deployedAddress = deployByteCode(vyperFileByteCode);
        return deployedAddress;
    }

    function deployContract(string memory fileLocation, bytes calldata args)
        public
        returns (address)
    {
        bytes memory bytecode = compileVyper(fileLocation, args);
        address deployedAddress = deployByteCode(bytecode);
        return deployedAddress;
    }
}
