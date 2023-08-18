const { expect } = require("chai");
// const { beforeEach } = require("mocha");
// const {ethers} = require("hardhat");
describe("Verify",function() {
    let verify,Aadhaar,Voter,police,user;
    beforeEach( async function() {
         [police,user] = await ethers.getSigners();
        
         const aadhaar = await ethers.getContractFactory("Aadhaar");
         Aadhaar = await aadhaar.deploy();

        const Verify = await ethers.getContractFactory("Verify");
        verify = await Verify.deploy();

    });

    describe("createPolice",async function() {
        
        it("Check for duplicate policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
           };
            
           const create1 = await verify.connect(police).createPolice(policeman);

           await expect(verify.connect(police).createPolice(policeman)).to.be.revertedWithCustomError(verify,"AccessDenied").withArgs("The policeman already exists.");
            
            
        })
        
        it("Check for name inclusion for policeman", async function() {
            var policeman = {   
                name : "",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
            };

           await expect(verify.connect(police).createPolice(policeman)).to.be.revertedWith("Name needs to be included");
            
        })

        it("Check for dob inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 0,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
            };

           await expect(verify.connect(police).createPolice(policeman)).to.be.revertedWith("Date of birth needs to be included");

        })

        it("Check for Station Address inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 759034,
                stationAddress : "",
                photoId : "ipfsAddress"
            };

           await expect(verify.connect(police).createPolice(policeman)).to.be.revertedWith("Station Address needs to be included");

        })

        it("Check for Photo of Id inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 759034,
                stationAddress : "Antriksh Greens",
                photoId : ""
            };

           await expect(verify.connect(police).createPolice(policeman)).to.be.revertedWith("Photo of Id needs to be included");

        })

        it("should create a policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
           };
            const create = await verify.connect(police).createPolice(policeman);
             
            await expect(create).to.emit(verify,"Police").withArgs(["Disha",72872178,"Antriksh Greens","ipfsAddress"],"Policeman created");
        });
        
    });

    describe("getPolice", async function() {
        var create;
        beforeEach(async function() {
            var policeman = {   
                name : "Disha",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
           };
             create = await verify.connect(police).createPolice(policeman);
        })

        it("does not exist as policeman", async function() {
            await expect(verify.getPolice(user.address)).to.be.revertedWithCustomError(verify,"AccessDenied").withArgs("The policeman doesn't exists.");
        })

        it("should retrieve the data", async function() {
            const get = await verify.getPolice(police.address);
            expect(get[0]).to.equals('Disha');
            expect(get[1]).to.equals(BigInt(72872178));
            expect(get[2]).to.equals("Antriksh Greens");
            expect(get[3]).to.equals("ipfsAddress");
        })

        
    });

    describe("verify", async function() {
       var aadharcard;
        beforeEach(async function() {

            var policeman = {   
                name : "Disha",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
           };

            const create = await verify.connect(police).createPolice(policeman);

            var demographicId = {
                name : "Disha",
                birthDate : 13092004,
                gender : "Female",
                homeAddress : "Antriksh Greens",
                mobileNumber : 989958219603,
                emailId : "dis@gmail.com"
            };

            var biometricId =[
                "fingerprint",
                "irisleft",
                "irisright",
                "photo"
            ];

            aadharcard =await Aadhaar.connect(user).createAadhar(demographicId,biometricId);
            aadharcard =await aadharcard.wait();
        });

        it("does not exist as policeman", async function() {
           await expect(verify.connect(user).verify(aadharcard.logs[0].args[0],Aadhaar.target)).to.be.revertedWith("Name needs to be included");
        });

        it("verifies aadharcard", async function() {
            const create = await verify.connect(police).verify(aadharcard.logs[0].args[0],Aadhaar.target);

            await expect(create).to.emit(verify,"aadharVerified").withArgs(aadharcard.logs[0].args[0],police.address,"Aadhar verified");
        });

        describe("Aadhar contract",async function() {

            it("user doesn't exist", async function() {
           await expect(verify.connect(police).verify("0x1ec76a53c6a393d0dc36ed3fc9c87e12db9163e378f4c512d13f6eb86efda26f",Aadhaar.target)).to.be.revertedWithCustomError(verify,"AccessDenied").withArgs("The id does not match any aadhar card holder id");
            });

            it("Aadhaar registered as verified", async function() {
            const create = await verify.connect(police).verify(aadharcard.logs[0].args[0],Aadhaar.target);
            await expect(create).to.emit(Aadhaar,"verified").withArgs(police.address,"Verification completed");
            
            })
        })
    })
})