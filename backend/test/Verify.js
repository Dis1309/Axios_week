const { expect } = require("chai");
const {ethers} = require("hardhat");
describe("Verify",function() {
    let verify,Aadhaar,Voter,police,user;
    beforeEach( async function() {
         [police,user] = await ethers.getSigners();
        
         const aadhaar = await ethers.getContractFactory("Aadhaar");
         Aadhaar = await aadhaar.deploy();

        const Verify = await ethers.getContractFactory("Verify");
        verify = await Verify.deploy();
        console.log(verify);

    });

    describe("createPolice",async function() {
        var policeman = {
             name : "Disha",
             dob : 13092004,
             stationAddress : "Antriksh Greens",
             photoId : "ipfsAddress"
        };
        it("should create a policeman", async function() {
            const create = await verify.connect(police).createPolice(policeman);
        })
        
    })
})