const { ethers } = require("hardhat");


//Deploying the contract on the Polygon network
async function main() {
    const aadhaar = await ethers.getContractFactory("Aadhaar");
    const AadhaarContract = await aadhaar.deploy();
    console.log(AadhaarContract.target);

   const Verify = await ethers.getContractFactory("Verify");
   const verifyContract = await Verify.deploy();
   console.log(verifyContract.target);

}

//Exporting the deployed contract
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});