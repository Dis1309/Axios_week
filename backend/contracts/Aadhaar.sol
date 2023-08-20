import './Verify.sol';
import './Structure.sol';
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
*@title Aadhar Card
*@author Disha Dwivedi
*@notice Creating , mantaining and editing a unique identification Aadhar card for the user
 */
contract Aadhaar is Structure{
  // Parameters required for Aadhar card
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


  // Modifier for limited access
  modifier onlyOwner(address user) {
    require(identity[user].bId.fingerprint.length != 0 ,"fingerprint not registered");
    require(identity[user].bId.irisLeft.length != 0 ,"Left Iris not registered");
    require(identity[user].bId.irisRight.length != 0 ,"Right Iris not registered");
    _;
  }


  // Custom errors for problem understanding
  error AccessDenied(string reason);
  error FormationDenied(string reason);
  error alreadyPresent(string present);


  // Events to notify user of the action
  event changeString(string param, string action);
  event changeInt(uint param, string action);
  event aadharMade(bytes32 Id, string required);
  event verified(address police, string action);


  // Storing Aadhar card and varification data
  mapping (address => id) internal  identity;
  mapping (bytes32 => address) internal uniqueId;
  mapping (bytes32 => address) public verification;

/*
*@notice Creates a unique identification Aadhar card for the user
*@param demographic and biometric data of the user
*@return Unique identification Id 
*/
  function createAadhar(demographicId memory _demographicId, string[] memory _biometricId) public   {
      if(identity[msg.sender].bId.fingerprint != 0x00 ) revert alreadyPresent({present : "The user already has a Aadharmade"});
      if(bytes(_biometricId[0]).length == 0 || bytes(_biometricId[1]).length == 0 || bytes(_biometricId[2]).length == 0 || bytes(_biometricId[3]).length == 0) revert FormationDenied({reason: "Biometric Data not complete"});
      if(bytes(_demographicId.name).length == 0 ||bytes(_demographicId.homeAddress).length == 0 || bytes(_demographicId.gender).length == 0 || _demographicId.birthDate == 0) revert FormationDenied({reason: "Demographic Data not complete"});
      identity[msg.sender].bId  = biometricId(keccak256(abi.encodePacked(_biometricId[0])),keccak256(abi.encodePacked(_biometricId[1])),keccak256(abi.encodePacked(_biometricId[2])),_biometricId[3]);
      identity[msg.sender].dId  = _demographicId;
      bytes32 _id = keccak256(abi.encodePacked(_biometricId[0], _biometricId[1], _biometricId[2],msg.sender));
      uniqueId[_id] = msg.sender;
      emit aadharMade(_id, "Verification needed");
  }
  
  /*
*@notice sets the verification of the police
*@param  unique Id and address of verifying policeman
 */
  function setVerification(bytes32  _id,address _police) external  {
    if(uniqueId[_id] == 0x0000000000000000000000000000000000000000) revert AccessDenied({reason : "The id does not match any aadhar card holder id"});
    verification[_id] = _police;

    emit verified(verification[_id],"Verification completed");
  }


/*
*@notice accessing the data of the verifying policeman
*@param unique Id and contract address forinteraction
*@return data of the policeman like name, photoId etc
 */
 function getPolice(bytes32 _id,address _address) external view returns (policeman memory ){
  if(verification[_id] == 0x0000000000000000000000000000000000000000) revert AccessDenied({reason : "The id is not verified yet"});
  Verify verify = Verify(_address);
  return verify.getPolice(verification[_id]);
 }


 /*
*@notice accessing all the unique data captured by Aadhar card
*@param fingerprint and unique Id
*@return the data one visible to public 
 */
  function getAll(string memory _fingerprint, bytes32 _uniqueid) public  view returns(id memory  _id) 
  {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    address check = uniqueId[_uniqueid];
    if(check == 0x0000000000000000000000000000000000000000) revert AccessDenied({reason : "The id does not match any aadhar card holder id"});
    if(check != msg.sender) revert AccessDenied({reason : "The id owner does not match the aadhar card holder"});
    //if(verification[_uniqueid] == 0x0000000000000000000000000000000000000000)  revert AccessDenied({reason : "The aadhar card has not been verified yet"});
    _id = identity[check];
  }


/*
*@notice All other functions are used to update the Aadhar card
*@param changing value, fingerprint and iris
*@return the value is updated 
*/
  function changePhotograph(string memory _photo,string memory _fingerprint,string memory _iris) external  {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].bId.photo = _photo;
    emit changeString(_photo,"Photograph changed");
  }

  function changeName(string memory _name,string memory _fingerprint,string memory _iris) external  {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.name = _name;
    emit changeString(_name,"Name changed");
  }

  function changebirthDate(uint _birthDate,string memory _fingerprint,string memory _iris) external  {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.birthDate = _birthDate;
    emit changeInt(_birthDate,"BirthDate changed");
  }

  function changegender(string memory _gender,string memory _fingerprint,string memory _iris) external   {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.gender = _gender;
    emit changeString(_gender,"Gender changed");
  }

  function changehomeAddress(string memory _homeAddress,string memory _fingerprint,string memory _iris) external  {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.homeAddress = _homeAddress;
    emit changeString(_homeAddress,"HomeAddress changed");
  }

  function changemobileNumber(uint _mobileNumber,string memory _fingerprint,string memory _iris) external{
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.mobileNumber = _mobileNumber;
    emit changeInt(_mobileNumber,"MobileNumber changed");
  }

  function changeemailId(string memory _emailId,string memory _fingerprint,string memory _iris) external {
    if(identity[msg.sender].bId.fingerprint != keccak256(abi.encodePacked(_fingerprint))) revert AccessDenied({ reason : "Incorrect Fingerprint"});
    if((identity[msg.sender].bId.irisLeft != keccak256(abi.encodePacked(_iris))) && (identity[msg.sender].bId.irisRight != keccak256(abi.encodePacked(_iris)))) revert AccessDenied({ reason : "Incorrect Iris Detection"});
    identity[msg.sender].dId.emailId = _emailId;
    emit changeString(_emailId,"EmailId changed");
  }
}