// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 private totalWaves;
    mapping (address => uint256) private waverToWaveCount;

    event NewWave(address indexed from, string message, uint256 blockNumber);

    struct Wave {
        address waver;
        string message;
        uint256 blockNumber;
    }

    Wave[] private waves;

    constructor() payable {
        console.log("Hey, I'm a smart contract! Nice to meet you.");
    }

    function wave(string memory _message) public {
        totalWaves++;
        waverToWaveCount[msg.sender]++;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.number));

        emit NewWave(msg.sender, _message, block.number);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Contract balance is too low."
        );
        payable(msg.sender).transfer(prizeAmount);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWaveCount(address _address) public view returns (uint256) {
        console.log("%s has %d waves!",  msg.sender, waverToWaveCount[msg.sender]);
        return waverToWaveCount[_address];
    }
}
