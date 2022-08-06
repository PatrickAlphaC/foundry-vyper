// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "src/VyperDeployer.sol";
import "forge-std/Test.sol";
import "test/testContracts/ISimpleStorage.sol";

contract VyperDeployerTest is Test {
    VyperDeployer public vyperDeployer;
    ISimpleStorage simpleStorage;
    string public constant simpleStorageLocation =
        "test/testContracts/SimpleStorage.vy";
    string public constant hasArgsLocation = "test/testContracts/HasArgs.vy";

    function setUp() public {
        vyperDeployer = new VyperDeployer();
        simpleStorage = ISimpleStorage(
            vyperDeployer.deployContract(simpleStorageLocation)
        );
    }

    function testCreationWithBytes() public {
        bytes memory compiledCode = vyperDeployer.compileVyper(
            simpleStorageLocation
        );
        address deployedContract = vyperDeployer.deployByteCode(compiledCode);
        assert(deployedContract != address(0));
    }

    function testStorageAndRead() public {
        uint256 numberToStore = 77;
        simpleStorage.storeNumber(numberToStore);
        assert(numberToStore == simpleStorage.readNumber());
    }

    function testCreationWithArgs() public {
        uint256 startingArgs = 77;
        ISimpleStorage hasArgs = ISimpleStorage(
            vyperDeployer.deployContract(
                hasArgsLocation,
                abi.encode(startingArgs)
            )
        );
        assert(startingArgs == hasArgs.readNumber());
    }
}
