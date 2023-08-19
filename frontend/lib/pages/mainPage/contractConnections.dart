import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:io';
import 'package:http/http.dart';

const String rpcUrl = 'http://127.0.0.1:8545/';
const String wsUrl = 'ws://127.0.0.1:8545/';

Credentials random = EthPrivateKey.fromHex(
    "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80");

EthereumAddress aadhaaraddress =
    EthereumAddress.fromHex("0x5FbDB2315678afecb367f032d93F642f64180aa3");
EthereumAddress voteraddress =
    EthereumAddress.fromHex("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0");
EthereumAddress verifyaddress =
    EthereumAddress.fromHex("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");
EthereumAddress otheraddress =
    EthereumAddress.fromHex("0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9");
EthereumAddress useraddress =
    EthereumAddress.fromHex("0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9");

final client = Web3Client(rpcUrl, Client(), socketConnector: () {
  return IOWebSocketChannel.connect(wsUrl).cast<String>();
});

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

// Aadhar functions
createAadhaar() async {
  final contract = await returnusercontract();
  final createAadhaar = contract.function("createAadhaar");
  return createAadhaar;
}

changePhotographAadhar() async {
  final contract = await returnusercontract();
  final changePhotograph = contract.function("changePhotograph");
  return changePhotograph;
}

changeNameAadhaar() async {
  final contract = await returnusercontract();
  final changeName = contract.function("changeName");
  return changeName;
}

setVerificationAadhaar() async {
  final contract = await returnusercontract();
  final setVerification = contract.function("createsetVerificationAadhaar");
  return setVerification;
}

getPoliceAadhaar() async {
  final contract = await returnusercontract();
  final getPolice = contract.function("getPolice");
  return getPolice;
}

getAllAadhaar() async {
  final contract = await returnusercontract();
  final getAll = contract.function("getAll");
  return getAll;
}

changebirthDateAadhaar() async {
  final contract = await returnusercontract();
  final changebirthDate = contract.function("changebirthDate");
  return changebirthDate;
}

changegenderAadhaar() async {
  final contract = await returnusercontract();
  final changegender = contract.function("changegender");
  return changegender;
}

changehomeAddressAadhaar() async {
  final contract = await returnusercontract();
  final changehomeAddress = contract.function("changehomeAddress");
  return changehomeAddress;
}

changemobileNumberAadhaar() async {
  final contract = await returnusercontract();
  final changemobileNumber = contract.function("changemobileNumber");
  return changemobileNumber;
}

changeemailIdAadhaar() async {
  final contract = await returnusercontract();
  final changeemailId = contract.function("changeemailId");
  return changeemailId;
}
