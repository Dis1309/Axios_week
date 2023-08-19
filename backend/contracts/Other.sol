// SPDX-License-Identifier : MIT

pragma solidity ^0.8.0;

import "./Aadhaar.sol";
contract Other is Aadhaar{
      
      struct otherdemographicid {
            string name ;
            uint dob ;
      }
      struct otherbiometricid {
            string photo;
      }
      struct otherid {
            otherdemographicid did ;
            otherbiometricid bid ;
      }

      struct document {
            bytes32 document_id;
            string documentPhotograph ;
            string documenttitle ;
      }

      event uploadDoc(bytes32 param , string action);
      event changeDoc (bytes32 param , string action);
      
      
      mapping (address =>  otherid) private otherIdentity;
      mapping (string => bytes32) private documentIdentification;
      mapping (address => bytes32[]) private documentFolder ;
      mapping (bytes32 => document) private documentFile ;
      
      modifier only_owner () {
            require(bytes(otherIdentity[msg.sender].bid.photo).length != 0 ,"Photo not registered");
            require(bytes(otherIdentity[msg.sender].did.name).length != 0,"Name not registered");
            require(otherIdentity[msg.sender].did.dob != 0 ,"Birth Date not registered");
            _; 
      }

      function uploadOtherDocuments ( otherdemographicid memory _other_did, string memory _fingerprint , string memory _document_photograph , string memory _documentTitle) public only_owner {
            if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
            string memory storedName = identity[msg.sender].dId.name;
            if(keccak256(abi.encodePacked(storedName)) != keccak256(abi.encodePacked(_other_did.name))) revert AccessDenied({reason:"Name is not the same as in Aadhar Card"});
            uint storeddob = identity[msg.sender].dId.birthDate;
            if(keccak256(abi.encodePacked(storeddob)) != keccak256(abi.encodePacked(_other_did.dob))) revert AccessDenied({reason:"DOB is not the same as in Aadhar Card"});
            bytes32 documentId = keccak256(abi.encodePacked(_documentTitle));
            documentFolder[msg.sender].push(documentId);
            documentFile[documentId] = document(documentId,_document_photograph , _documentTitle);
            emit uploadDoc(documentId, "Document uploaded to this address");
      }

      function changeDocumentPhotograph(otherdemographicid memory _other_did, string memory _fingerprint , string memory _document_photograph , string memory _document_title) public only_owner {
            if ( identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied ({ reason : "Incorrect Fingerprint"});
            string memory storedName = identity[msg.sender].dId.name;
            if(keccak256(abi.encodePacked(storedName)) != keccak256(abi.encodePacked(_other_did.name))) revert AccessDenied({reason:"Name is not the same as in Aadhar Card"});
            uint storeddob = identity[msg.sender].dId.birthDate;
            if(keccak256(abi.encodePacked(storeddob)) != keccak256(abi.encodePacked(_other_did.dob))) revert AccessDenied({reason:"DOB is not the same as in Aadhar Card"});
            require (documentFolder[msg.sender].length != 0 , "No documents have been uploaded");
            bytes32 document_id = keccak256(abi.encodePacked(_document_title));
            bytes32[] storage docs = documentFolder[msg.sender] ;
            documentFile[document_id].documentPhotograph = _document_photograph ;
            emit changeDoc(document_id, "Document changed");
      }
}