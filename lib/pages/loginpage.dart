import 'dart:convert';
import 'package:bosscitykeys/constants/strings.dart';
import 'package:bosscitykeys/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bosscitykeys/pages/vehiclespage.dart';
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
      children: <Widget> [
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: _controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ]
  );

}

Widget buildPassword(TextEditingController _controllerPassword) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: _controllerPassword,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
        )
      ]
  );

}

Widget buildLoginButton(BuildContext context,TextEditingController _controllerEmail,TextEditingController _controllerPassword){
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 25
    ),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: (){
       /* final API_MANAGER loginAPI = new API_MANAGER();
        var email = _controllerEmail.text;
        var password = _controllerPassword.text;
        loginAPI.login(email, password, "test");*/
        login(context,_controllerEmail,_controllerPassword);
      },
      child: Text('Sign in'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(15),
        primary: Colors.amber,
      ),
    ),
  );
}



class _LoginPageState extends State<LoginPage> {
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
            children: <Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffffd202),
                          Color(0xffffda31),
                          Color(0xffffde48),
                          Color(0xffffe25f),
                        ]
                    )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        child: Image.asset('assets/images/big.png'),
                        width: 170,
                        height: 80,
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      buildEmail(_controllerEmail),
                      SizedBox(height: 20),
                      buildPassword(_controllerPassword),
                      buildLoginButton(context,_controllerEmail,_controllerPassword),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
Future<void> login(BuildContext context,TextEditingController _controllerEmail,TextEditingController _controllerPassword) async{
  if(_controllerEmail.text.isNotEmpty && _controllerPassword.text.isNotEmpty){
    var deviceName = "test_device";
    var client = http.Client();
    var loginResponse = await client.post(
      Uri.parse(Strings.login_url),
      body: ({
        'email' : _controllerEmail.text,
        'password' : _controllerPassword.text,
        'device_name' : deviceName,
      }),
    );


    if(loginResponse.statusCode == 200){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => VehiclePage()),);
      var token = loginResponse.body;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid credentials")));
    }
  }else{
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Please fill in all fields"),));
  }
}
