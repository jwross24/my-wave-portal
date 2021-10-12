import { ethers } from "hardhat";

async function main() {
  const [owner, randomPerson] = await ethers.getSigners();
  const waveContractFactory = await ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave();
  await waveTxn.wait();

  await waveContract.getTotalWaves();
  await waveContract.getWaveCount(owner.address);

  waveTxn = await waveContract.connect(randomPerson).wave();
  await waveTxn.wait();

  await waveContract.getTotalWaves();
  await waveContract.getWaveCount(randomPerson.address);
}

async function runMain() {
  try {
    await main();
    process.exitCode = 0;
  } catch (error) {
    console.log(error);
    process.exitCode = 1;
  }
}

runMain();
