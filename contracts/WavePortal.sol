// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 private totalWaves;
    mapping (address => uint256) private waverToWaveCount;

    constructor() {
        console.log("Hey, I'm a smart contract! Nice to meet you.");
    }

    function wave() public {
        totalWaves++;
        waverToWaveCount[msg.sender]++;
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        string memory waveModifier = getWaveModifierString(totalWaves);
        console.log("We have %d total wave%s!", totalWaves, waveModifier);
        return totalWaves;
    }

    function getWaveCount(address _address) public view returns (uint256) {
        string memory waveModifier = getWaveModifierString(waverToWaveCount[msg.sender]);
        console.log("%s has %d wave%s!",  msg.sender, waverToWaveCount[msg.sender], waveModifier);
        return waverToWaveCount[_address];
    }

    function getWaveModifierString(uint256 _waves) private pure returns (string memory) {
        return _waves == 1 ? "" : "s";
    }
}
