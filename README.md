# Foundry/Vyper

<br/>
<p align="center">
<img src="./img/vyper-logo.png" width="225" alt="Vyper logo">
<img src="./img/foundry-logo.png" width="225" alt="Vyper logo">
</p>
<br/>

A package for running, deploying, and working with vyper contracts in a foundry setup. 

# Table of Contents
- [Foundry/Vyper](#foundryvyper)
- [Table of Contents](#table-of-contents)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
    - [Deploying with arguments](#deploying-with-arguments)
- [Acknowledgments](#acknowledgments)

# Getting Started

## Requirements

The following will need to be installed in order to use this template. Please follow the links and instructions.

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
    -   To get the latest of each, just run `foundryup`
-   [Vyper Compiler](https://vyper.readthedocs.io/en/stable/installing-vyper.html)
    -   You'll know you've done it right if you can run `vyper --version` and get an output like: `0.3.4+commit.f31f0ec`

## Quickstart

1. Install the package. 
```
forge install PatrickAlphaC/foundry-vyper --no-commit
```

2. Update `remappings.txt`

Either make a `remappings.txt` file or just add the following to it:

```
foundry-vyper/=lib/foundry-vyper/src/
```

3. Use the Vyper Deployer Contract!

```javascript
import "foundry-vyper/VyperDeployer.sol";
import "src/interfaces/ISimpleStorage.sol";
.
.
.
function deploy() public {
    string vyperSimpleStorageLocation = "src/VSimpleStorage.vy";
    vyperDeployer = new VyperDeployer();
    address vyContractAddress = vyperDeployer.deployContract(vyperSimpleStorageLocation);
    ISimpleStorage simpleStorage = ISimpleStorage(vyContractAddress); 
}
```

### Deploying with arguments

To deploy with arguments, just abi encode your arguments:

```
vyperDeployer.deployContract("SimpleStore", abi.encode(1234))
```

# Acknowledgments

- [0xKitsune/Foundry-Vyper](https://github.com/0xKitsune/Foundry-Vyper)
- [Foundry/Huff](https://github.com/huff-language/foundry-huff)