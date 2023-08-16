
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Aadhaar {

  struct demographicId {
    string  name;
    uint birthDate;
    string  gender;
    string  homeAddress;
    uint mobileNumber;
    string  emailId;
  }

  struct  biometricId {
    bytes32  fingerprint;
    bytes32  irisLeft;
    bytes32  irisRight;
    string  photo;
  }

  struct id {
    biometricId bId;
    demographicId dId;
  }

  modifier onlyOwner() {
    require(identity[msg.sender].bId.fingerprint != 0x00 ,"Left Iris not registered");
    require(identity[msg.sender].bId.irisLeft != 0x00 ,"Left Iris not registered");
    require(identity[msg.sender].bId.irisRight != 0x00 ,"Right Iris not registered");
    require(bytes(identity[msg.sender].bId.photo).length != 0 ,"Photo not registered");
    require(bytes(identity[msg.sender].dId.name).length != 0,"Name not registered");
    require(identity[msg.sender].dId.birthDate != 0 ,"Birth Date not registered");
    require(bytes(identity[msg.sender].dId.gender).length != 0 ,"Gender not registered");
    require(bytes(identity[msg.sender].dId.homeAddress).length != 0 ,"Home Address not registered");
    _;
  }

  error AccessDenied(string reason);
  event changeString(string param, string action);
  event changeInt(uint param, string action);

   mapping (address => id) public identity;
  constructor(demographicId memory _demographicId, string[] memory _biometricId) {
      identity[msg.sender].bId  = biometricId(keccak256(abi.encodePacked(_biometricId[0])),keccak256(abi.encodePacked(_biometricId[1])),keccak256(abi.encodePacked(_biometricId[2])),_biometricId[3]);
      identity[msg.sender].dId  = _demographicId;
      identity[msg.sender].bId  = biometricId(keccak256(abi.encodePacked(_biometricId[0])),keccak256(abi.encodePacked(_biometricId[1])),keccak256(abi.encodePacked(_biometricId[2])),_biometricId[3]);
      identity[msg.sender].dId  = _demographicId;
  }

  function getAll(string memory _fingerprint) public onlyOwner view returns(id memory _id) {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    _id = identity[msg.sender];
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    _id = identity[msg.sender];
  }

  function changePhotograph(string memory _photo,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].bId.photo = _photo;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].bId.photo = _photo;
    emit changeString(_photo,"Photograph changed");
  }

  function changeName(string memory _name,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.name = _name;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.name = _name;
    emit changeString(_name,"Name changed");
  }

  function changebirthDate(uint _birthDate,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.birthDate = _birthDate;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.birthDate = _birthDate;
    emit changeInt(_birthDate,"BirthDate changed");
  }

  function changegender(string memory _gender,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.gender = _gender;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.gender = _gender;
    emit changeString(_gender,"Gender changed");
  }

  function changehomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.homeAddress = _homeAddress;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.homeAddress = _homeAddress;
    emit changeString(_homeAddress,"HomeAddress changed");
  }

  function changemobileNumber(uint _mobileNumber,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.mobileNumber = _mobileNumber;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.mobileNumber = _mobileNumber;
    emit changeInt(_mobileNumber,"MobileNumber changed");
  }

  function changeemailId(string memory _emailId,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.emailId = _emailId;
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.emailId = _emailId;
    emit changeString(_emailId,"EmailId changed");
  }
}