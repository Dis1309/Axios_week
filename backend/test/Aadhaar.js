const { expect } = require("chai");

describe("Aadhar" , async function() {
    let verify,Aadhaar,Voter,aadharcard,police,user,user2,user3,create,policeman;
    var demographicId,demographicId;
    beforeEach( async function() {
         [police,user3,user2,user] = await ethers.getSigners();
        
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

        policeman = {   
            name : "Disha",    
            dob : 72872178,
            stationAddress : "Antriksh Greens",
            photoId : "ipfsAddress"
       };
         create = await verify.connect(police).createPolice(policeman);

    });

    describe("createAadhar", async function() {

        it("checks for already existing user", async function() {

           await expect(Aadhaar.connect(user).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"alreadyPresent").withArgs("The user already has a Aadharmade");

        });

        it("checks for biometric data", async function() {
            biometricId =[
                "",
                "irisleft",
                "irisright",
                "photo"
            ];

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Biometric Data not complete");

            
        });

        it("checks for presence of name", async function() {
            demographicId = {
                name : "",
                birthDate : 13092004,
                gender : "Female",
                homeAddress : "Antriksh Greens",
                mobileNumber : 989958219603,
                emailId : "dis@gmail.com"
            };

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");

            
        });

        it("checks for presence of gender", async function() {
            demographicId = {
                name : "Disha",
                birthDate : 13092004,
                gender : "",
                homeAddress : "Antriksh Greens",
                mobileNumber : 989958219603,
                emailId : "dis@gmail.com"
            };

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");

            
        });

        it("checks for presence of birthDate", async function() {
            demographicId = {
                name : "Disha",
                birthDate : 0,
                gender : "Female",
                homeAddress : "Antriksh Greens",
                mobileNumber : 989958219603,
                emailId : "dis@gmail.com"
            };

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");

            
        });

        it("checks for presence of Home Address", async function() {
            demographicId = {
                name : "Disha",
                birthDate : 13092004,
                gender : "Female",
                homeAddress : "",
                mobileNumber : 989958219603,
                emailId : "dis@gmail.com"
            };

           await expect(Aadhaar.connect(user2).createAadhar(demographicId,biometricId)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");

            
        });

        it("checks for optional demographic data - Number and email", async function() {
            demographicId = {
                name : "Disha",
                birthDate : 13092004,
                gender : "Female",
                homeAddress : "Antriksh Greens",
                mobileNumber : 989958219603,
                emailId : ""
            };

           await Aadhaar.connect(user2).createAadhar(demographicId,biometricId);

            
        });

        it("aadhar is created", async function() {

           var create = await Aadhaar.connect(user2).createAadhar(demographicId,biometricId);
           create = await create.wait();
           const id = create.logs[0].args[0];

           await expect(create).to.emit(Aadhaar,"aadharMade").withArgs(id,"Verification needed");
            
        });

    });

    describe("getPolice", async function() {
        var verified;

        it("Aadhar card not verified yet",async function() {
           await expect(Aadhaar.getPolice(aadharcard.logs[0].args[0],verify.target)).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("The id is not verified yet");
        });

        it("getting police information", async function() {
            verified = await verify.connect(police).verify(aadharcard.logs[0].args[0],Aadhaar.target);
            const get = await Aadhaar.getPolice(aadharcard.logs[0].args[0],verify.target);
            expect(get[0]).to.equals('Disha');
            expect(get[1]).to.equals(BigInt(72872178));
            expect(get[2]).to.equals("Antriksh Greens");
            expect(get[3]).to.equals("ipfsAddress");
        })

    });

    describe("getAll", async function() {

        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).getAll("Incorrect fingerprint",aadharcard.logs[0].args[0])).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong id", async function() {
            await expect(Aadhaar.connect(user).getAll("fingerprint","0x1ec76a53c6a393d0dc36ed3fc9c87e12db9163e378f4c512d13f6eb87efda26f")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("The id does not match any aadhar card holder id");
        });

        it("different aadhar card holder", async function() {
            var aadharcard2 = await Aadhaar.connect(user2).createAadhar(demographicId,biometricId);
            aadharcard2 = await aadharcard2.wait();
            await expect(Aadhaar.connect(user2).getAll("fingerprint",aadharcard.logs[0].args[0])).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("The id owner does not match the aadhar card holder");
        });

        it("unverified aadhar card", async function() {
            await expect(Aadhaar.connect(user).getAll("fingerprint",aadharcard.logs[0].args[0])).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("The aadhar card has not been verified yet");
        });

        it("accessible Aadhar card", async function() {
            verified = await verify.connect(police).verify(aadharcard.logs[0].args[0],Aadhaar.target);
            
           const get = await  Aadhaar.connect(user).getAll("fingerprint",aadharcard.logs[0].args[0]);
           expect(get[0][0]).to.equals('0x7321f0614d883d6a9409bee785ea1d4fa1d462d8b3b5ff72f60b95d53cbc250b');
            expect(get[0][1]).to.equals('0x7056d3efeef75dc2a829be935490bb72cb4901460e2fe21229a55a305a38b57e');
            expect(get[0][2]).to.equals('0xd52a7065f3558155d81420b1a557e7dd7b9c5c24b0b4f27eda63fca1fc9e5569');
            expect(get[0][3]).to.equals("photo");
            expect(get[1][0]).to.equals('Disha');
            expect(get[1][1]).to.equals(BigInt(13092004));
            expect(get[1][2]).to.equals("Female");
            expect(get[1][3]).to.equals("Antriksh Greens");
            expect(get[1][4]).to.equals(BigInt(989958219603));
            expect(get[1][5]).to.equals("dis@gmail.com");
        });

    });

    describe("update information functions",async function() {
        
       describe("changePhotograph", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changePhotograph("Photograph","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changePhotograph("Photograph","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("Photograph changed", async function() {
            const create = await Aadhaar.connect(user).changePhotograph("Photograph","fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeString").withArgs("Photograph","Photograph changed");
        });
       });

       describe("changeName", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changeName("Shaurya","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changeName("Shaurya","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("Name changed", async function() {
            const create = await Aadhaar.connect(user).changeName("Shaurya","fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeString").withArgs("Shaurya","Name changed");
        });
       });

       describe("changebirthDate", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changebirthDate(Number("01022009") ,"Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changebirthDate(Number("01022009") ,"fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("BirthDate changed", async function() {
            const create = await Aadhaar.connect(user).changebirthDate(Number("01022009") ,"fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeInt").withArgs(Number("01022009") ,"BirthDate changed");
        });
       });

       describe("changegender", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changegender("Male","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changegender("Male","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("Gender changed", async function() {
            const create = await Aadhaar.connect(user).changegender("Male","fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeString").withArgs("Male","Gender changed");
        });
       });

       describe("changehomeAddress", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changehomeAddress("Glory,Gurugram","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changehomeAddress("Glory,Gurugram","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("HomeAddress changed", async function() {
            const create = await Aadhaar.connect(user).changehomeAddress("Glory,Gurugram","fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeString").withArgs("Glory,Gurugram","HomeAddress changed");
        });
       });

       describe("changemobileNumber", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changemobileNumber(Number("8595803635") ,"Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changemobileNumber(Number("8595803635") ,"fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("MobileNumber changed", async function() {
            const create = await Aadhaar.connect(user).changemobileNumber(Number("8595803635") ,"fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeInt").withArgs(Number("8595803635") ,"MobileNumber changed");
        });
       });

       describe("changeemailId", async function() {
        
        it("wrong fingerprint", async function() {
            await expect(Aadhaar.connect(user).changeemailId("sd@gmail.com","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
        });

        it("wrong iris", async function() {
            await expect(Aadhaar.connect(user).changeemailId("sd@gmail.com","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
        });

        it("EmailId changed", async function() {
            const create = await Aadhaar.connect(user).changeemailId("sd@gmail.com","fingerprint","irisright");
           await expect(create).to.emit(Aadhaar,"changeString").withArgs("sd@gmail.com","EmailId changed");
        });
       });
    })
})