import "./Aadhaar.sol";
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

abstract contract Voter is Aadhaar{
      
      struct voterdemographicid {
            string name ;
            uint dob ;
            string gender ;
            string home_address;
            uint phonenumber;
            string guardian_type; // father or spouse
            string guardian_name;
      }

      struct voterbiometricid {
            bytes32  photo;
      }
      struct voterid {
            voterdemographicid did ;
            voterbiometricid bid ;
      }
      mapping (address => voterid) private  voteridentity;
      mapping (bytes32 => address) private uniqueVoterId;

      
      error alreadyExists(string message);
      error noExistence(string message);

      event voterIdMade (bytes32 param, string action);
      event deletedVoterId (string param, string action);

      modifier onlyVoter () {
            require((voteridentity[msg.sender].bid.photo).length != 0 ,"Photo not registered");
            require(bytes(voteridentity[msg.sender].did.name).length != 0,"Name not registered");
            require(voteridentity[msg.sender].did.dob != 0 ,"Birth Date not registered");
            require(bytes(voteridentity[msg.sender].did.gender).length != 0 ,"Gender not registered");
            require(bytes(voteridentity[msg.sender].did.home_address).length != 0 ,"Home Address not registered");
            _; 
      }


      function createVoterId (voterdemographicid memory _voterdid , string memory _voterbid ) public {
            if (voteridentity[msg.sender].did.dob != 0  || bytes(voteridentity[msg.sender].did.guardian_type).length != 0 || bytes(voteridentity[msg.sender].did.guardian_name).length != 0 && bytes(voteridentity[msg.sender].did.home_address).length != 0 ) revert alreadyExists({ message : "Voter's Identity already exists"});
            if(bytes(_voterbid).length == 0 ) revert FormationDenied({reason: "Biometric Data not complete"});
            if(bytes(_voterdid.name).length == 0 ||bytes(_voterdid.home_address).length == 0 || bytes(_voterdid.gender).length == 0 || (_voterdid.dob) == 0 || bytes(_voterdid.guardian_name).length == 0 || bytes(_voterdid.guardian_type).length == 0) revert FormationDenied({reason: "Voter's Demographic Data not complete"});
            voteridentity[msg.sender].did = _voterdid ;
            voteridentity[msg.sender].bid = voterbiometricid(keccak256(abi.encodePacked(_voterbid))) ;
            bytes32 _voter_id = keccak256(abi.encodePacked( _voterdid.name, _voterdid.dob , _voterbid ));
            uniqueVoterId[_voter_id] = msg.sender;

            emit voterIdMade(_voter_id, "Voter Id made successfully");
      }

      function changephotograph(string memory _photo,string memory _fingerprint,string memory _iris)private {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].bid.photo = keccak256(abi.encodePacked(_photo));
      emit changeString(_photo,"Photograph changed");
      }

      function changename(string memory _name,string memory _fingerprint,string memory _iris) private {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.name)) != keccak256(abi.encodePacked(_name))) revert AccessDenied({reason:"Name is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.name = _name;
      emit changeString(_name,"Name changed");
      }

      function changedob(uint _dob,string memory _fingerprint,string memory _iris) private {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(identity[msg.sender].dId.birthDate != _dob) revert AccessDenied({reason:"Date of birth is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.dob = _dob;
      emit changeInt(_dob,"BirthDate changed");
      }

      function changeGender(string memory _gender,string memory _fingerprint,string memory _iris)private  {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.gender)) != keccak256(abi.encodePacked(_gender))) revert AccessDenied({reason:"Gender is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.gender = _gender;
      emit changeString(_gender,"Gender changed");
      }

      function changeHomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris)private  {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.homeAddress)) != keccak256(abi.encodePacked(_homeAddress))) revert AccessDenied({reason:"Home Address is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.home_address = _homeAddress;
      emit changeString(_homeAddress,"HomeAddress changed");
      }

      function changephoneNumber(uint _phoneNumber,string memory _fingerprint,string memory _iris)private  {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].did.phonenumber = _phoneNumber;
      emit changeInt(_phoneNumber,"PhoneNumber changed");
      }

      function changeGuardian (string memory _guardian_type , string memory _guardian_name , string memory _fingerprint , string memory _iris) private {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].did.guardian_name = _guardian_name;
      voteridentity[msg.sender].did.guardian_type = _guardian_type;
      emit changeString(_guardian_name,"Guardian changed");
      }
      
      function cancelVoterId (string memory _fingerprint , string memory _iris) onlyVoter public {
            if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
            if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
            if (voteridentity[msg.sender].did.dob == 0  || bytes(voteridentity[msg.sender].did.guardian_type).length == 0 || bytes(voteridentity[msg.sender].did.guardian_name).length == 0 || bytes(voteridentity[msg.sender].did.home_address).length == 0 ) revert noExistence({ message : "Voter's Identity doesn't exists"});
            voteridentity[msg.sender].did.dob == 0 ;
            // voteridentity[msg.sender].did.guardian_type == "" ;
            // voteridentity[msg.sender].did.guardian_name == "" ;
            // voteridentity[msg.sender].did.home_address == "" ;
            // voteridentity[msg.sender].did.guardian_type == "" ;
            // voteridentity[msg.sender].did.guardian_name == "" ;
            // voteridentity[msg.sender].did.home_address == "" ;
            delete voteridentity[msg.sender] ;

            emit deletedVoterId("delete", "Voter id deleted");
      }
}
