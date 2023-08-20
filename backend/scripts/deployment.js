const { ethers } = require("hardhat");


//Deploying the contract on the Polygon network
async function main() {
    const aadhaar = await ethers.getContractFactory("Aadhaar");
    const AadhaarContract = await aadhaar.deploy();
    console.log(AadhaarContract.target);

   // const Verify = await ethers.getContractFactory("Verify");
   // const verifyContract = await Verify.deploy();
   // console.log(verifyContract.target);
   
   // const voter = await ethers.getContractFactory("Voter");
   // const VoterContract = await voter.deploy();
   // console.log(VoterContract.target);
   
   // const other = await ethers.getContractFactory("Other");
   // const OtherContract = await other.deploy();
   // console.log(OtherContract.target);

   const userInfo = await ethers.getContractFactory("userInfo");
   const UserInfo = await userInfo.deploy();
   console.log(UserInfo.target);

}

//Exporting the deployed contract
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});