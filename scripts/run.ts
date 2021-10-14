import { ethers } from "hardhat";

async function main() {
  const waveContractFactory = await ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);

  let contractBalance = await ethers.provider.getBalance(waveContract.address);
  console.log("Contract balance: ", ethers.utils.formatEther(contractBalance));

  const waveTxn = await waveContract.wave("This is wave #1");
  await waveTxn.wait();

  const waveTxn2 = await waveContract.wave("This is wave #2");
  await waveTxn2.wait();

  contractBalance = await ethers.provider.getBalance(waveContract.address);
  console.log("Contract balance: ", ethers.utils.formatEther(contractBalance));

  const allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
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
