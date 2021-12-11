
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    /**Helps us generate a random number */
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }
    Wave[] waves;

    mapping(address => uint256) public lastWaveAt;
    constructor() payable{
         console.log("Yo yo, I am a contract i am smart");
         /*
         *Set the initial seed to a random number
         */
         seed = (block.timestamp + block.difficulty) % 100;
    }
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log(" has waved %s times", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        /*
        *Generate a new seed for each new user that sends a wave
        */
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        if (seed <= 50){
            console.log("%s won!", msg.sender);
            /*
            *The same code we had before we send a prize 0.01 ether to the winner
            */
            uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
  
    }
    
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    
    function getTotalWaves() public view returns (uint) {
        console.log(" has waved %s times",  totalWaves);
        return totalWaves;
    }
}