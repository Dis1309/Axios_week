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
  final usercontract = DeployedContract(
    ContractAbi.fromJson(abi, 'userInfo'), useraddress);
  return usercontract;
}
returnAadhaarAbi() async {
  final String abi = await rootBundle.loadString('assets/aadhaarabi.json');
  return abi;
}
returnVoterAbi() async {
  final String abi = await rootBundle.loadString('assets/voterabi.json');
  return abi;
}

returnOtherAbi() async {
  final String abi = await rootBundle.loadString('assets/otherabi.json');
  return abi;
}

returnVerifyAbi() async {
  final String abi = await rootBundle.loadString('assets/verifyabi.json');
  return abi;
}


final votercontract = DeployedContract(
    ContractAbi.fromJson(returnVoterAbi(), 'Voter'), voteraddress);
final aadhaarcontract = DeployedContract(
    ContractAbi.fromJson(returnAadhaarAbi(), 'Aadhaar'), aadhaaraddress);
final verifycontract = DeployedContract(
    ContractAbi.fromJson(returnVerifyAbi(), 'Verify'), verifyaddress);
final othercontract = DeployedContract(
    ContractAbi.fromJson(returnOtherAbi(), 'Other'), otheraddress);
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
// returnCreateAadhaar() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto() {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }
// returnchangeAadhaarPhoto  () {
//   final createAadhaar = aadhaarcontract.function("createAadhaar");
//   return createAadhaar;
// }