
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    constructor(){
        console.log("Yo yo, I am a contract i am smart");
    }
    function wave() public {
        totalWaves += 1;
        console.log(" has waved %s times", msg.sender);
    }

    function getTotalWaves() public view returns (uint) {
        console.log(" has waved %s times",  totalWaves);
        return totalWaves;
    }
}