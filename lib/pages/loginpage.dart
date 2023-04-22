import 'dart:convert';
import 'package:bosscitykeys/constants/strings.dart';
import 'package:bosscitykeys/pages/Register.dart';
import 'package:bosscitykeys/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bosscitykeys/pages/vehiclespage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Widget buildEmail(TextEditingController _controllerEmail) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: _controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
          ),
        )
      ]);
}

Widget buildPassword(TextEditingController _controllerPassword) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: _controllerPassword,
            obscureText: true,
            style: const TextStyle(
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
          ),
        )
      ]);
}

Widget buildLoginButton(
    BuildContext context,
    bool _isLoading,
    TextEditingController _controllerEmail,
    TextEditingController _controllerPassword) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        login(context, _isLoading, _controllerEmail, _controllerPassword);
      },
      child: const Text('Sign in'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        primary: Colors.amber,
      ),
    ),
  );
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  //Future<TokenInfo>? _tokenInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xffffd202),
                      Color(0xffffda31),
                      Color(0xffffde48),
                      Color(0xffffe25f),
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/big.png'),
                        width: 170,
                        height: 80,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildEmail(_controllerEmail),
                      const SizedBox(height: 20),
                      buildPassword(_controllerPassword),
                      const SizedBox(height: 20),

                      _isLoading
                          ? const SpinKitChasingDots(
                              color: Colors.white,
                            ):
                      //     : buildLoginButton(context, _isLoading,
                      //         _controllerEmail, _controllerPassword),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(_controllerEmail.text.isNotEmpty&&_controllerPassword.text.isNotEmpty){

                            setState(() {
                              _isLoading= true;
                            });
                            login(context, _isLoading, _controllerEmail,
                                _controllerPassword);
                            } else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fill in all details')));
                            }

                          },
                          child: const Text('Sign in'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(15),
                            primary: Colors.amber,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Register()));
                                },
                                child: const Icon(
                                  CupertinoIcons.phone_arrow_down_left,
                                  // color: Colors.white,
                                  size: 30,
                                )),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Register()));
                                },
                                child: const Text(
                                  'Need a Tracker? Register. ',
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Align(
              //     alignment: Alignment.bottomLeft,
              //     child: Container(
              //       margin:
              //           const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           InkWell(
              //               onTap: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (context) => const Register()));
              //               },
              //               child: const Icon(
              //                 CupertinoIcons.phone_arrow_down_left,
              //                 // color: Colors.white,
              //                 size: 30,
              //               )),
              //           InkWell(
              //               onTap: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (context) => const Register()));
              //               },
              //               child: const Text(
              //                 'Need a Tracker? Register. ',
              //                 style: TextStyle(
              //                   // color: Colors.white,
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ))
              //         ],
              //       ),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> login(
    BuildContext context,
    bool _isLoading,
    TextEditingController _controllerEmail,
    TextEditingController _controllerPassword) async {
  if (_controllerEmail.text.isNotEmpty && _controllerPassword.text.isNotEmpty) {
    var deviceName = "test_device";
    var client = http.Client();
    var loginResponse = await client.post(
      Uri.parse(Strings.login_url),
      body: ({
        'email': _controllerEmail.text,
        'password': _controllerPassword.text,
        'device_name': deviceName,
      }),
    );

    if (loginResponse.statusCode == 200) {
      debugPrint("LoginResp ${loginResponse.body}");
      _isLoading = false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const VehiclePage()),
      );
      var token = loginResponse.body;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid credentials")));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please fill in all fields"),
    ));
  }
}
