const { expect } = require("chai");

describe("Aadhar" , async function() {
    let verify,Aadhaar,Voter,aadharcard,police,user,user2;
    var demographicId,demographicId;
    beforeEach( async function() {
         [police,user,user2] = await ethers.getSigners();
        
         const aadhaar = await ethers.getContractFactory("Aadhaar");
         Aadhaar = await aadhaar.deploy();

        const Verify = await ethers.getContractFactory("Verify");
        verify = await Verify.deploy();

        demographicId = {
            name : "Disha",
            birthDate : 13092004,
            gender : "Female",
            homeAddress : "Antriksh Greens",
            mobileNumber : 989958219603,
            emailId : "dis@gmail.com"
        };

        biometricId =[
            "fingerprint",
            "irisleft",
            "irisright",
            "photo"
        ];

        aadharcard =await Aadhaar.connect(user).createAadhar(demographicId,biometricId);
        aadharcard =await aadharcard.wait();

    });

    describe("createAadhar", async function() {

        it("checks for already existing user", async function() {

           await expect(Aadhaar.connect(user).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"alreadyPresent").withArgs("The user already has a Aadharmade");

        });

        it("checks for biometric Id", async function() {
            biometricId =[
                "",
                "irisleft",
                "irisright",
                "photo"
            ];

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Biometric Data not complete");

            
        });

    })
})