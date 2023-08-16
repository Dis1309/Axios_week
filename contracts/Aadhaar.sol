// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Aadhaar {
  address immutable owner;

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
    require(msg.sender == owner,"The person does not own the respective aadhar card");
    _;
  }

  error AccessDenied(string reason);
  event changeString(string param, string action);
  event changeInt(uint param, string action);

  id private identity;
  constructor(demographicId memory _demographicId, string[] memory _biometricId) {
      owner = msg.sender;
      identity.bId  = biometricId(keccak256(abi.encodePacked(_biometricId[0])),keccak256(abi.encodePacked(_biometricId[1])),keccak256(abi.encodePacked(_biometricId[2])),_biometricId[3]);
      identity.dId  = _demographicId;
  }

  function getAll(string memory _fingerprint) public onlyOwner view returns(id memory _id) {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    _id = identity;
  }

  function changePhotograph(string memory _photo,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.bId.photo = _photo;
    emit changeString(_photo,"Photograph changed");
  }

  function changeName(string memory _name,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.name = _name;
    emit changeString(_name,"Name changed");
  }

  function changebirthDate(uint _birthDate,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.birthDate = _birthDate;
    emit changeInt(_birthDate,"BirthDate changed");
  }

  function changegender(string memory _gender,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.gender = _gender;
    emit changeString(_gender,"Gender changed");
  }

  function changehomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.homeAddress = _homeAddress;
    emit changeString(_homeAddress,"HomeAddress changed");
  }

  function changemobileNumber(uint _mobileNumber,string memory _fingerprint,string memory _iris)private  onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.mobileNumber = _mobileNumber;
    emit changeInt(_mobileNumber,"MobileNumber changed");
  }

  function changeemailId(string memory _emailId,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity.bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity.bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity.bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity.dId.emailId = _emailId;
    emit changeString(_emailId,"EmailId changed");
  }
}