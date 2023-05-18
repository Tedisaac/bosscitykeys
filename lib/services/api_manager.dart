import 'dart:convert';
import 'dart:io';

import 'package:bosscitykeys/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class API_MANAGER {

  Future<http.Response> login(String email, String password) async {
    var deviceName = await _getId();
    var client = http.Client();
    var loginResponse = await client.post(
      Uri.parse(Strings.login_url),
      body: ({
        'email': email,
        'password': password,
        'device_name': deviceName,
      }),
    );
    return loginResponse;
  }

  Future<http.Response> register(String name, String email, String phoneNumber, String password) async {
    var deviceName = await _getId();
    var client = http.Client();
    var registerResponse = await client.post(
      Uri.parse(Strings.register_url),
      body: ({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'device_name': deviceName,
      }),
    );
    return registerResponse;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}