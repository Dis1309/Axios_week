import './Verify.sol';
import './Structure.sol';
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Aadhaar is Structure{

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
    _;
  }

  modifier onlyAadhar() {
     require(bytes(identity[msg.sender].bId.photo).length != 0 ,"Photo not registered");
    require(bytes(identity[msg.sender].dId.name).length != 0,"Name not registered");
    require(identity[msg.sender].dId.birthDate != 0 ,"Birth Date not registered");
    require(bytes(identity[msg.sender].dId.gender).length != 0 ,"Gender not registered");
    require(bytes(identity[msg.sender].dId.homeAddress).length != 0 ,"Home Address not registered");
    _;
  }

  error AccessDenied(string reason);
  error FormationDenied(string reason);
  error alreadyPresent(string present);
  event changeString(string param, string action);
  event changeInt(uint param, string action);
  event aadharMade(bytes32 Id, string required);
  event verified(address police, string action);

  mapping (address => id) internal  identity;
  mapping (bytes32 => address) internal uniqueId;
  mapping (bytes32 => address) public verification;
  function createAadhar(demographicId memory _demographicId, string[] memory _biometricId) public   {
      if(identity[msg.sender].bId.fingerprint != 0x00 ) revert alreadyPresent({present : "The user already has a Aadharmade"});
      if(bytes(_biometricId[0]).length == 0 || bytes(_biometricId[1]).length == 0 || bytes(_biometricId[2]).length == 0 || bytes(_biometricId[3]).length == 0) revert FormationDenied({reason: "Biometric Data not complete"});
      identity[msg.sender].bId  = biometricId(keccak256(abi.encodePacked(_biometricId[0])),keccak256(abi.encodePacked(_biometricId[1])),keccak256(abi.encodePacked(_biometricId[2])),_biometricId[3]);
      identity[msg.sender].dId  = _demographicId;
      bytes32 _id = keccak256(abi.encodePacked(_biometricId[0], _biometricId[1], _biometricId[2]));
      uniqueId[_id] = msg.sender;
      emit aadharMade(_id, "Verification needed");
  }
  
  function setVerification(bytes32  _id,address _police) external  {
    if(uniqueId[_id] == 0x0000000000000000000000000000000000000000) revert AccessDenied({reason : "The id does not match any aadhar card holder id"});
    verification[_id] = _police;

    emit verified(_police,"Verification completed");
  }

 function getPolice(address _police,address _address) external view returns (policeman memory ){
  Verify verify = Verify(_address);
  return verify.getPolice(_police);
 }
  function getAll(string memory _fingerprint, bytes32 _uniqueid) public onlyOwner onlyAadhar view returns(id memory  _id) {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    address check = uniqueId[_uniqueid];
    if(check == 0x0000000000000000000000000000000000000000) revert AccessDenied({reason : "The id does not match any aadhar card holder id"});
    if(check != msg.sender) revert AccessDenied({reason : "The id does not match any aadhar card holder"});
    if(verification[_uniqueid] == 0x0000000000000000000000000000000000000000)  revert AccessDenied({reason : "The aadhar card has not been verified yet"});
    _id = identity[check];
  }

  function changePhotograph(string memory _photo,string memory _fingerprint,string memory _iris)private  onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].bId.photo = _photo;
    emit changeString(_photo,"Photograph changed");
  }

  function changeName(string memory _name,string memory _fingerprint,string memory _iris) private onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.name = _name;
    emit changeString(_name,"Name changed");
  }

  function changebirthDate(uint _birthDate,string memory _fingerprint,string memory _iris) private onlyOwner {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.birthDate = _birthDate;
    emit changeInt(_birthDate,"BirthDate changed");
  }

  function changegender(string memory _gender,string memory _fingerprint,string memory _iris)private  onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.gender = _gender;
    emit changeString(_gender,"Gender changed");
  }

  function changehomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris)private  onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.homeAddress = _homeAddress;
    emit changeString(_homeAddress,"HomeAddress changed");
  }

  function changemobileNumber(uint _mobileNumber,string memory _fingerprint,string memory _iris)private  onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.mobileNumber = _mobileNumber;
    emit changeInt(_mobileNumber,"MobileNumber changed");
  }

  function changeemailId(string memory _emailId,string memory _fingerprint,string memory _iris) private onlyOwner onlyAadhar {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) || (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.emailId = _emailId;
    emit changeString(_emailId,"EmailId changed");
  }
}