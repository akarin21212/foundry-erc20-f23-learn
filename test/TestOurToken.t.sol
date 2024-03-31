// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract TestOurToken is Test {

    DeployOurToken public deploy;
    OurToken public ourToken;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALABCE = 100 ether;

    function setUp() public {
        deploy = new DeployOurToken();
        ourToken = deploy.run();

        vm.prank(msg.sender);//因为在 Solidity 中，合约的创建者（即合约的部署者）在合约的构造函数中执行了 new 操作符，创建了一个新的合约实例。在这个过程中，当前的交易上下文中的消息发送者（即部署 DeployOurToken 合约的账户）将会成为新合约的创建者和拥有者。
        ourToken.transfer(bob, STARTING_BALABCE);
    }

    function testBobBalance() public view {
        assert(ourToken.balanceOf(bob) == STARTING_BALABCE);
    }

    function testAllowances() public {
        uint256 initialAllowce = 1000;
        uint256 transferAmount = 500;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowce);

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALABCE-transferAmount);
    }
}