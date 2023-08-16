import "./Aadhaar.sol";
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

abstract contract Voter is Aadhaar{
      struct voterdemographicid {
            string name;
            string guardian_name;
            string gender ;
            uint dob ;
            string home_address;
            uint phonenumber;
      }

      struct voterbiometricid {
            string  photo;
      }
      struct voterid {
            voterdemographicid did ;
            voterbiometricid bid ;
      }
      mapping (address => voterid) private  voteridentity;

      modifier onlyowner () {
            require(identity[msg.sender].bId.fingerprint != 0x00 ,"Left Iris not registered");
            require(identity[msg.sender].bId.irisLeft != 0x00 ,"Left Iris not registered");
            require(identity[msg.sender].bId.irisRight != 0x00 ,"Right Iris not registered");
            require(bytes(voteridentity[msg.sender].bid.photo).length != 0 ,"Photo not registered");
            require(bytes(voteridentity[msg.sender].did.name).length != 0,"Name not registered");
            require(voteridentity[msg.sender].did.dob != 0 ,"Birth Date not registered");
            require(bytes(voteridentity[msg.sender].did.gender).length != 0 ,"Gender not registered");
            require(bytes(voteridentity[msg.sender].did.home_address).length != 0 ,"Home Address not registered");
            _; 
      }

      constructor(voterdemographicid memory _voterdemographicId, string memory _voterbiometricId) {
            voteridentity[msg.sender].bid  = voterbiometricid(_voterbiometricId);
            voteridentity[msg.sender].did  = _voterdemographicId;

      }

      function changephotograph(string memory _photo,string memory _fingerprint,string memory _iris)private  onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].bid.photo = _photo;
      emit changeString(_photo,"Photograph changed");
      }

      function changename(string memory _name,string memory _fingerprint,string memory _iris) private onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.name)) != keccak256(abi.encodePacked(_name))) revert AccessDenied({reason:"Name is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.name = _name;
      emit changeString(_name,"Name changed");
      }

      function changedob(uint _dob,string memory _fingerprint,string memory _iris) private onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(identity[msg.sender].dId.birthDate != _dob) revert AccessDenied({reason:"Date of birth is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.dob = _dob;
      emit changeInt(_dob,"BirthDate changed");
      }

      function changeGender(string memory _gender,string memory _fingerprint,string memory _iris)private  onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.gender)) != keccak256(abi.encodePacked(_gender))) revert AccessDenied({reason:"Gender is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.gender = _gender;
      emit changeString(_gender,"Gender changed");
      }

      function changeHomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris)private  onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      if(keccak256(abi.encodePacked(identity[msg.sender].dId.homeAddress)) != keccak256(abi.encodePacked(_homeAddress))) revert AccessDenied({reason:"Home Address is not the same as in Aadhar Card"});
      voteridentity[msg.sender].did.home_address = _homeAddress;
      emit changeString(_homeAddress,"HomeAddress changed");
      }

      function changephoneNumber(uint _phoneNumber,string memory _fingerprint,string memory _iris)private  onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].did.phonenumber = _phoneNumber;
      emit changeInt(_phoneNumber,"PhoneNumber changed");
      }

      function changeGuardianName (string memory _guardian_name , string memory _fingerprint , string memory _iris) private onlyowner {
      if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
      if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
      voteridentity[msg.sender].did.guardian_name = _guardian_name;
      emit changeString(_guardian_name,"GuardianName changed");
      }

}
