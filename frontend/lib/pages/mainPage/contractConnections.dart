import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

getPref() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs;
}
const String rpcUrl = 'https://eth-sepolia.g.alchemy.com/v2/yCAYbdA_3YXtbwJE0XNC9K27RmuXgKWn';
const String wsUrl = 'wss://eth-sepolia.g.alchemy.com/v2/yCAYbdA_3YXtbwJE0XNC9K27RmuXgKWn';

Credentials random = EthPrivateKey.fromHex(
    "0x668d91844cb5c21dc699c539ef1479b3dc3368eccd7c4688eab800d4bdb04722");



//! Contract addresses
EthereumAddress aadhaaraddress =
    EthereumAddress.fromHex("0xACA9cd7cAbeE67162AEddAFe1d1022388c4125e3");
EthereumAddress voteraddress =
    EthereumAddress.fromHex("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0");
EthereumAddress verifyaddress =
    EthereumAddress.fromHex("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");
EthereumAddress otheraddress =
    EthereumAddress.fromHex("0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9");
EthereumAddress useraddress =
    EthereumAddress.fromHex("0xFdb2DD3565f4d709e87EAf222C082736983a1Ec9");

Future<dynamic> main() async {
  final client = Web3Client(rpcUrl, Client(), socketConnector: () {
  return IOWebSocketChannel.connect(wsUrl).cast<String>();
});
return client;
}


//! Contract Instances
returnusercontract() async {
  final String abi = await rootBundle.loadString('assets/userabi.json');
  final usercontract =
      DeployedContract(ContractAbi.fromJson(abi, 'userInfo'), useraddress);
  return usercontract;
}

returnverifycontract() async {
  final String abi = await rootBundle.loadString('assets/verifyabi.json');
  final verifycontract =
      DeployedContract(ContractAbi.fromJson(abi, 'Verify'), verifyaddress);
  return verifycontract;
}

returnaadhaarcontract() async {
  final String abi = await rootBundle.loadString('assets/aadhaarabi.json');
  final aadhaarcontract =
      DeployedContract(ContractAbi.fromJson(abi, 'Aadhaar'), aadhaaraddress);
  return aadhaarcontract;
}

returnvotercontract() async {
  final String abi = await rootBundle.loadString('assets/voterabi.json');
  final votercontract =
      DeployedContract(ContractAbi.fromJson(abi, 'Voter'), voteraddress);
  return votercontract;
}

returnothercontract() async {
  final String abi = await rootBundle.loadString('assets/otherabi.json');
  final othercontract =
      DeployedContract(ContractAbi.fromJson(abi, 'Other'), otheraddress);
  return othercontract;
}

//! UserInfo functions

setUser() async {
  final contract = await returnusercontract();
  final setuser = contract.function("setUser");
  return setuser;
}

getUser() async {
  final contract = await returnusercontract();
  final getuser = contract.function("getUser");
  return getuser;
}

//!  Aadhar functions
createAadhaar() async {
  final contract = await returnaadhaarcontract();
  final createaadhaar = contract.function("createAadhar");
  return createaadhaar;
}

changePhotographAadhar() async {
  final contract = await returnaadhaarcontract();
  final changePhotograph = contract.function("changePhotograph");
  return changePhotograph;
}

changeNameAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changeName = contract.function("changeName");
  return changeName;
}

setVerificationAadhaar() async {
  final contract = await returnaadhaarcontract();
  final setVerification = contract.function("setVerification");
  return setVerification;
}

getPoliceAadhaar() async {
  final contract = await returnaadhaarcontract();
  final getPolice = contract.function("getPolice");
  return getPolice;
}

getAllAadhaar() async {
  final contract = await returnaadhaarcontract();
  final getAll = contract.function("getAll");
  return getAll;
}

changebirthDateAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changebirthDate = contract.function("changebirthDate");
  return changebirthDate;
}

changegenderAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changegender = contract.function("changegender");
  return changegender;
}

changehomeAddressAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changehomeAddress = contract.function("changehomeAddress");
  return changehomeAddress;
}

changemobileNumberAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changemobileNumber = contract.function("changemobileNumber");
  return changemobileNumber;
}

changeemailIdAadhaar() async {
  final contract = await returnaadhaarcontract();
  final changeemailId = contract.function("changeemailId");
  return changeemailId;
}

//! Voter functions

createVoterId() async {
  final contract = await returnvotercontract();
  final createVoterId = contract.function("createVoterId");
  return createVoterId;
}

changenameVoter() async {
  final contract = await returnvotercontract();
  final changename = contract.function("changename");
  return changename;
}

changedobVoter() async {
  final contract = await returnvotercontract();
  final changedob = contract.function("changedob");
  return changedob;
}

changephotographVoter() async {
  final contract = await returnvotercontract();
  final changephotograph = contract.function("changephotograph");
  return changephotograph;
}

changeGenderVoter() async {
  final contract = await returnvotercontract();
  final changeGender = contract.function("createVochangeGenderterId");
  return changeGender;
}

changeHomeAddressVoter() async {
  final contract = await returnvotercontract();
  final changeHomeAddress = contract.function("changeHomeAddress");
  return changeHomeAddress;
}

changephoneNumberVoter() async {
  final contract = await returnvotercontract();
  final changephoneNumber = contract.function("changephoneNumber");
  return changephoneNumber;
}

changeGuardianVoter() async {
  final contract = await returnvotercontract();
  final changeGuardian = contract.function("changeGuardian");
  return changeGuardian;
}

//! Verify functions

createPoliceVerify() async {
  final contract = await returnverifycontract();
  final createPolice = contract.function("createPolice");
  return createPolice;
}

getPoliceVerify() async {
  final contract = await returnverifycontract();
  final getPolice = contract.function("getPolice");
  return getPolice;
}

verifyV() async {
  final contract = await returnverifycontract();
  final verify = contract.function("verify");
  return verify;
}

//! Other functions

uploadOtherDocuments() async {
  final contract = await returnothercontract();
  final uploadOtherDocuments = contract.function("uploadOtherDocuments");
  return uploadOtherDocuments;
}

changeDocumentPhotograph() async {
  final contract = await returnothercontract();
  final changeDocumentPhotograph =
      contract.function("changeDocumentPhotograph");
  return changeDocumentPhotograph;
}
