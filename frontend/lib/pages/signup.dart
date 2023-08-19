// import 'dart:html';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:web3dart/web3dart.dart';
import 'package:path/path.dart' show join, dirname;
import 'dart:math';
import 'package:web_socket_channel/io.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'dart:async';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import './mainPage/contractConnections.dart';


// import 'abi.json'
final File abiFile = File(join(dirname(Platform.script.path), './abi.json'));
// const abi = [
//   {
//     "inputs": [
//       {
//         "internalType": "string",
//         "name": "_email",
//         "type": "string"
//       },
//       {
//         "internalType": "string",
//         "name": "_password",
//         "type": "string"
//       }
//     ],
//     "name": "getUser",
//     "outputs": [
//       {
//         "internalType": "string",
//         "name": "",
//         "type": "string"
//       }
//     ],
//     "stateMutability": "view",
//     "type": "function"
//   },
//   {
//     "inputs": [
//       {
//         "internalType": "string",
//         "name": "_name",
//         "type": "string"
//       },
//       {
//         "internalType": "string",
//         "name": "_email",
//         "type": "string"
//       },
//       {
//         "internalType": "string",
//         "name": "_password",
//         "type": "string"
//       }
//     ],
//     "name": "setUser",
//     "outputs": [],
//     "stateMutability": "nonpayable",
//     "type": "function"
//   }
// ];


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Color favColor = Color(0xFF4C39C3);
  var name, email, password;
  void initState() {
    super.initState();
    name = "";
    email = "";
    password = "";
  }

  interaction() async {
    
    await client.sendTransaction(
      random,
      chainId: 31337,
      Transaction.callContract(
        contract: usercontract,
        function: setuser,
        parameters: [name.toString(), email.toString(), password.toString()],
      ),
    );
  }

  var signer;
  loginUsingMetamask(BuildContext context) async {
    print(0);
    AuthClient authClient = await AuthClient.createInstance(
      relayUrl:
          'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: 'a7ddf2eec463c08990cb608fce62a504',
      metadata: PairingMetadata(
        name: 'Aadhar_Card',
        description: 'Creates Aadhaar card',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );
//     ConnectResponse resp = await authClient.connect(
//   requiredNamespaces: {
//     'eip155': RequiredNamespace(
//       chains: ['eip155:1'], // Ethereum chain
//       methods: ['eth_signTransaction'], // Requestable Methods
//       events: ['eth_sendTransaction'], // Requestable Events
//     ),
//   }
// );
    final AuthRequestResponse authResponse = await authClient.request(
      params: AuthRequestParams(
        aud: 'https://rpc-mumbai.maticvigil.com/',
        domain: 'rpc-mumbai.maticvigil.com',
        chainId: "eip155:80001",
        statement: 'Sign in with your wallet!',
      ),
      // pairingTopic: resp.pairingTopic,
    );

    final uri = authResponse.uri;
    final url = 'https://metamask.app.link/wc?uri=' + uri.toString();
    print(await url);
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }

//     final AuthRequestResponse authReq = await wcClient.requestAuth(
//   params: AuthRequestParams(
//     aud: 'https://172.70.104.217:43793/login',
//     domain: '172.70.104.217:43793',
//     chainId: 'eip155',
//     statement: 'Sign in with your wallet!',
//   ),
//   pairingTopic: resp.pairingTopic,
// );
// final Completer<AuthResponse> authResponse = await authReq.completer;
// print(await authResponse);
// try{
    final AuthResponse auth = await authResponse.completer.future;
    print(auth == null);
    if (auth.result != null) {
      print(2);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));

      final walletAddress = AddressUtils.getDidAddress(auth.result!.p.iss);
    } else {
      print(1);
      // Otherwise, you might have gotten a WalletConnectError if there was un issue verifying the signature.
      final WalletConnectError? error = auth.error;
      // Of a JsonRpcError if something went wrong when signing with the wallet.
      final JsonRpcError? Error = auth.jsonRpcError;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Sign Up'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Log in with Metamask',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              ElevatedButton.icon(
                onPressed: () => loginUsingMetamask(context),
                icon: Image.asset(
                  'assets/metamask.gif',
                  height: 40.0,
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0)),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size.fromHeight(30)),
                    backgroundColor: MaterialStateProperty.all<Color>(favColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                label: Text(
                  'Connect with metamask now!!!',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Text(
                'Or',
                style:
                    TextStyle(fontSize: 25.0, color: Colors.deepPurpleAccent),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Register using email and password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your email',
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your password',
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () => interaction(),
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: favColor,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Click here',
                        style: TextStyle(fontSize: 16.0, color: favColor),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
