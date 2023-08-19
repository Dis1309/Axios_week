const { expect } = require("chai");

describe("Other", function () {
    let otherInstance, AadhaarInstance, owner, user;

    beforeEach(async function () {
        [owner, user] = await ethers.getSigners();

        const Aadhaar = await ethers.getContractFactory("Aadhaar");
        AadhaarInstance = await Aadhaar.deploy();

        const Other = await ethers.getContractFactory("Other");
        otherInstance = await Other.deploy();
    });

    describe("uploadOtherDocuments", function () {
        it("should upload other documents", async function () {
            // Prepare inputs
            const fingerprint = "fingerprint";
            const documentPhotograph = "documentPhotograph";
            const documentTitle = "documentTitle";

            // Create Aadhaar identity
            await AadhaarInstance.createIdentity("Name", 123456, fingerprint);

            // Upload other documents
            await expect(
                otherInstance.connect(user).uploadOtherDocuments(
                    { name: "Name", dob: 123456 },
                    fingerprint,
                    documentPhotograph,
                    documentTitle
                )
            ).to.emit(otherInstance, "uploadDoc");

            // Verify the document was uploaded
            const documentId = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(documentTitle));
            const document = await otherInstance.documentFile(documentId);
            expect(document.documentPhotograph).to.equal(documentPhotograph);
            expect(document.documenttitle).to.equal(documentTitle);
        });
    });

    describe("changeDocumentPhotograph", function () {
        it("should change document photograph", async function () {
            // Prepare inputs
            const fingerprint = "fingerprint";
            const documentPhotograph = "documentPhotograph";
            const documentTitle = "documentTitle";

            // Create Aadhaar identity and upload a document
            await AadhaarInstance.createIdentity("Name", 123456, fingerprint);
            await otherInstance.connect(user).uploadOtherDocuments(
                { name: "Name", dob: 123456 },
                fingerprint,
                documentPhotograph,
                documentTitle
            );

            // Change document photograph
            const newDocumentPhotograph = "newDocumentPhotograph";
            await expect(
                otherInstance.connect(user).changeDocumentPhotograph(
                    { name: "Name", dob: 123456 },
                    fingerprint,
                    newDocumentPhotograph,
                    documentTitle
                )
            ).to.emit(otherInstance, "changeDoc");

            // Verify the document photograph was changed
            const documentId = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(documentTitle));
            const updatedDocument = await otherInstance.documentFile(documentId);
            expect(updatedDocument.documentPhotograph).to.equal(newDocumentPhotograph);
            expect(updatedDocument.documenttitle).to.equal(documentTitle);
        });
    });

});
