// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract SampleUnits {
    modifier betweenOneAndTwoEth(){
        // require(msg.value >= 1000000000000000000 && msg.value <= 2000000000000000000);
        // require(msg.value >= 1e18 && msg.value <= 2e18);
        require(msg.value >= 1 ether && msg.value <= 2 ether);
        _;
    }

    // ether
    // gwei
    // wei

    uint runUntilTimestamp;
    uint startTimestamp;

    constructor (uint startInDays) {
        // startTimestamp = block.timestamp + (startInDays * 24 * 60 * 60);
        startTimestamp = block.timestamp + (startInDays * 1 days);
        // runUntilTimestamp = startTimestamp + (7*24*60*60);
        runUntilTimestamp = startTimestamp + (7 days);
    }

    // seconds
    // minutes
    // hours
    // days
    // weeks
}