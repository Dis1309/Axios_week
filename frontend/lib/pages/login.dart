import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/pages/fingerprint.dart';
import 'package:frontend/pages/mainPage/mainPage.dart';
import 'package:frontend/pages/signup.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'dart:async';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import 'package:web3dart/web3dart.dart';
import 'signup.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' show join, dirname;
import 'dart:math';
import 'package:web_socket_channel/io.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'dart:async';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import './mainPage/contractConnections.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final Color favColor = Color(0xFF4C39C3);

class _LoginState extends State<Login> {
  var email, password;
  void initState() {
    super.initState();
    email = "";
    password = "";
  }

  interaction(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    final usercontract = await returnusercontract();
    final getuser = await getUser();
    final client = await main();
    final ans = await client.call(
      contract: usercontract,
      function: getuser,
      params: [email, password],
    );
    if ("Non-existing user" != ans.first.toString() &&
        "Incorrect password" != ans.first.toString()) {
      final pref = await getPref();
      await pref.setString('Name', ans.first.toString());
      await pref.setString('Email', email);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FingerPrint()));
    } else {
      scaffold.showSnackBar(SnackBar(
        content: Text('Error loggin in'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ));
    }
    print(ans.first.toString());
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
        aud: 'https://172.70.104.217:43793/login',
        domain: '172.70.104.217:43793',
        chainId: 'eip155:1',
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
  // var connector = WalletConnect(
  //     bridge: 'https://bridge.walletconnect.org',
  //     clientMeta: const PeerMeta(
  //         name: 'My App',
  //         description: 'An app for converting pictures to NFT',
  //         url: 'https://walletconnect.org',
  //         icons: [
  //           'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //         ]));

  // var _session, _uri, _signature, session;

  // loginUsingMetamask(BuildContext context) async {
  //   if (!connector.connected) {
  //     try {
  //       session = await connector.createSession(onDisplayUri: (uri) async {
  //         _uri = uri;
  //         await launchUrlString(uri, mode: LaunchMode.externalApplication);
  //       });
  //       print(session.accounts[0]);
  //       setState(() {
  //         _session = session;
  //       });
  //     } catch (exp) {
  //       print(exp);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     Container(
              //       width: MediaQuery.of(context).size.width/2.5,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         border: Border.all(color: Colors.black,width: 2.0)
              //       ),
              //       child: IconButton(
              //         iconSize: 40.0,
              //         onPressed: (){},
              //         icon: Image.asset('assets/google.png'),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width/2.5,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           border: Border.all(color: Colors.black,width: 2.0)
              //       ),
              //       child: IconButton(
              //         iconSize: 40.0,
              //         onPressed: (){},
              //         icon: Image.asset('assets/github.png'),
              //       ),
              //     )
              //   ],
              // ),
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
                'Login using email and password',
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
                          labelText: 'Enter your email',
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
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
                  onPressed: () => interaction(context),
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: favColor,
                  child: Text(
                    'Login',
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
                    'Not yet registered?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Click here',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: favColor,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
