const {expect} = require ("chai");

describe ("Voter" , async function () {
      let aadhaar, voter , aadhaarcard , user, Aadhaar , Voter , voterr , user2, user3;
      var voterdemographicid , voterbiometricid;
      beforeEach( async function () {
            [user, user2 , user3] = await ethers.getSigners();

            const aadhaar = await ethers.getContractFactory("Aadhaar");
            Aadhaar = await aadhaar.deploy();

            const voter = await ethers.getContractFactory("Voter");
            Voter = await voter.deploy();


            voterdemographicid = {
                  name : "Joe",
                  dob : 17032004,
                  gender : "Female",
                  home_address : "Guindy, Chennai",
                  phonenumber : 9992034819,
                  guardian_type : "Father",
                  guardian_name : "Chandler Bing XD"
            }

            voterbiometricid = "voter_photo";

            voterr = await Voter.connect(user).createVoterId(voterdemographicid,voterbiometricid);
      });

      describe("createVoterId", async function() {
            it("creates a voter identity", async function() {
        
                await expect(voterr)
                    .to.emit(Voter, "voterIdMade")
                    .withArgs("voterIdHash", "Voter Id made successfully");
        
                // Check if the voter identity was correctly created
                const voterId = await Voter.voteridentity(user);
                expect(voterId.did.name).to.equal(voterdemographicid.name);
                expect(voterId.bid.photo).to.equal(keccak256(abi.encodePacked(voterbiometricid)));
            });
        
            it("checks for biometric data", async function() {
                  voterbiometricid = ""
      
                 await expect(Voter.connect(user).createAadhar(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Biometric Data not complete");
      
                  
              });
      
              it("checks for presence of name", async function() {
                  voterdemographicid = {
                        name : "",
                        dob : 17032004,
                        gender : "Female",
                        home_address : "Guindy, Chennai",
                        phonenumber : 9992034819,
                        guardian_type : "Father",
                        guardian_name : "Chandler Bing XD"
                  };
      
                 await expect(Voter.connect(user2).createVoterId(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");
      
                  
              });
      
              it("checks for presence of gender", async function() {
                  voterdemographicid = {
                        name : "Joe",
                        dob : 17032004,
                        gender : "",
                        home_address : "Guindy, Chennai",
                        phonenumber : 9992034819,
                        guardian_type : "Father",
                        guardian_name : "Chandler Bing XD"
                  };
      
                  await expect(Voter.connect(user2).createVoterId(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");
      
                  
              });
      
              it("checks for presence of birthDate", async function() {
                  voterdemographicid = {
                        name : "Joe",
                        dob : 0,
                        gender : "Female",
                        home_address : "Guindy, Chennai",
                        phonenumber : 9992034819,
                        guardian_type : "Father",
                        guardian_name : "Chandler Bing XD"
                  };
      
                  await expect(Voter.connect(user2).createVoterId(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");
      
                  
                  
              });
      
              it("checks for presence of Home Address", async function() {
                  voterdemographicid = {
                        name : "Joe",
                        dob : 17032004,
                        gender : "Female",
                        home_address : "",
                        phonenumber : 9992034819,
                        guardian_type : "Father",
                        guardian_name : "Chandler Bing XD"
                  };
      
                  await expect(Voter.connect(user2).createVoterId(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");
      
                  
              });
      
              it("checks for guardian information : name and type", async function() {
                  voterdemographicid = {
                        name : "Joe",
                        dob : 17032004,
                        gender : "Female",
                        home_address : "Guindy, Chennai",
                        phonenumber : 9992034819,
                        guardian_type : "",
                        guardian_name : ""
                  };
      
                  await expect(Voter.connect(user2).createVoterId(voterdemographicid,voterbiometricid)).to.be.revertedWithCustomError(Aadhaar,"FormationDenied").withArgs("Demographic Data not complete");
      
                  
                  
              });
        
            it("fails to create a voter identity if identity already exists", async function() {
                console.log(Voter.logs);
                await expect(Voter.connect(user).createVoterId(voterdemographicid,voterbiometricid)).to.be.reverterWithCustomError(Voter,"alreadyExists").withArgs("The user already has a Voter Id made");

            });
        });
        describe("update information functions",async function() {
        
            describe("changephotograph", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changephotograph("Photograph","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changephotograph("Photograph","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("Photograph changed", async function() {
                 const create = await Voter.connect(user).changephotograph("Photograph","fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeString").withArgs("Photograph","Photograph changed");
             });
            });
     
            describe("changename", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changename("Jae","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changename("Jae","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("Name changed", async function() {
                 const create = await Voter.connect(user).changename("Jae","fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeString").withArgs("Jae","Name changed");
             });
            });
     
            describe("changedob", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changedob(Number("01022009") ,"Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changedob(Number("01022009") ,"fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("BirthDate changed", async function() {
                 const create = await Voter.connect(user).changedob(Number("01022009") ,"fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeInt").withArgs(Number("01022009") ,"BirthDate changed");
             });
            });
     
            describe("changeGender", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changeGender("Male","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changeGender("Male","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("Gender changed", async function() {
                 const create = await Voter.connect(user).changeGender("Male","fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeString").withArgs("Male","Gender changed");
             });
            });
     
            describe("changeHomeAddress", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changeHomeAddress("RKPuram, Delhi","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changeHomeAddress("RKPuram, Delhi","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("HomeAddress changed", async function() {
                 const create = await Voter.connect(user).changehomeAddress("RKPuram, Delhi","fingerprint","irisright");
                await expect(create).to.emit(Voter,"changeString").withArgs("RKPuram, Delhi","HomeAddress changed");
             });
            });
     
            describe("changePhoneNumber", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changePhoneNumber(Number("9999000998") ,"Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changePhoneNumber(Number("9999000998") ,"fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("PhoneNumber changed", async function() {
                 const create = await Voter.connect(user).changePhoneNumber(Number("9999000998") ,"fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeInt").withArgs(Number("9999000998") ,"PhoneNumber changed");
             });
            });
     
            describe("changeGuardian", async function() {
             
             it("wrong fingerprint", async function() {
                 await expect(Voter.connect(user).changeGuardian("Spouse","Ali","Incorrect fingerprint","irisleft")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Fingerprint");
             });
     
             it("wrong iris", async function() {
                 await expect(Voter.connect(user).changeGuardian("Spouse","Ali","fingerprint","irisNone")).to.be.revertedWithCustomError(Aadhaar,"AccessDenied").withArgs("Incorrect Iris Detection");
             });
     
             it("EmailId changed", async function() {
                 const create = await Voter.connect(user).changeGuardian("Spouse","Ali","fingerprint","irisright");
                await expect(create).to.emit(Aadhaar,"changeString").withArgs("Ali","Guardian changed");
             });
            });
         })
        
})