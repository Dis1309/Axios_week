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
            
           verify.connect(police).createPolice(policeman).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals('AccessDenied("The policeman already exists.")');
           });
            
        })
        
        it("Check for name inclusion for policeman", async function() {
            var policeman = {   
                name : "",    
                dob : 72872178,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
            };
            verify.connect(police).createPolice(policeman).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals("Name needs to be included");
           });
        })

        it("Check for dob inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 0,
                stationAddress : "Antriksh Greens",
                photoId : "ipfsAddress"
            };
            verify.connect(police).createPolice(policeman).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals("Date of birth needs to be included");
           });
        })

        it("Check for Station Address inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 759034,
                stationAddress : "",
                photoId : "ipfsAddress"
            };
            verify.connect(police).createPolice(policeman).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals("Station Address needs to be included");
           });
        })

        it("Check for Photo of Id inclusion for policeman", async function() {
            var policeman = {   
                name : "Disha",    
                dob : 759034,
                stationAddress : "Antriksh Greens",
                photoId : ""
            };
            verify.connect(police).createPolice(policeman).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals("Photo of Id needs to be included");
           });
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
            verify.getPolice(user.address).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals((AccessDenied("The policeman doesn't exists.")).toString());
           });
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
            verify.connect(user).verify(aadharcard.logs[0].args[0],Aadhaar.target).then((res) => {console.log(res);})
           .catch(async (e) => {
             expect(e).to.equals((AccessDenied("The policeman doesn't exists.")).toString());
           });
        });

        it("verifies aadharcard", async function() {
            const create = await verify.connect(police).verify(aadharcard.logs[0].args[0],Aadhaar.target);

            await expect(create).to.emit(verify,"aadharVerified").withArgs(aadharcard.logs[0].args[0],police.address,"Aadhar verified");
        });

        
    })
})