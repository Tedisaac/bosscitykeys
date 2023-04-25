import 'dart:convert';

import 'package:bosscitykeys/constants/strings.dart';
import 'package:http/http.dart' as http;

class API_MANAGER {

  void login(String email,String password,String deviceName) async{
    var client = http.Client();
    var loginResponse = await client.post(
        Uri.parse(Strings.login_url),
        body: jsonEncode(<String, String>{
          'email' : email,
          'password' : password,
          'device_name' : deviceName,
    }),
    );

    if(loginResponse.statusCode == 200){
      var jsonString = loginResponse.body;
    }
  }
}