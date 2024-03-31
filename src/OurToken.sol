// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurToken is ERC20 {
    constructor (uint256 initialSupply) ERC20("y", "yy") {
       _mint(msg.sender, initialSupply);
    }
}