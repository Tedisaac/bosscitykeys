import 'package:bosscitykeys/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bosscitykeys/services/api_manager.dart';

import '../constants/strings.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var response;
  final API_MANAGER _api_manager = API_MANAGER();
  bool _isLoading = false;
  TextEditingController _controllerfName = TextEditingController();
  TextEditingController _controllerlName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Get a tracker'),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.amberAccent,
          child: Container(
            margin: EdgeInsets.only(right: 16, left: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'First Name',
                          style: TextStyle(
                            color: Colors.black54,
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
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                            controller: _controllerfName,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: 'First Name',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                          ),
                        )
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            color: Colors.black54,
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
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
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
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black54,
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
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                            obscureText: true,
                            controller: _controllerPassword,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                          ),
                        )
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: Colors.black54,
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
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                            controller: _controllerPhone,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                          ),
                        ),
                        _isLoading
                            ? const SpinKitChasingDots(
                                color: Colors.white,
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_controllerfName.text.isNotEmpty &&
                                        _controllerEmail.text.isNotEmpty &&
                                        _controllerPhone.text.isNotEmpty &&
                                        _controllerPassword.text.isNotEmpty) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      response = _api_manager
                                          .register(
                                              _controllerfName.text,
                                              _controllerEmail.text,
                                              _controllerPhone.text,
                                              _controllerPassword.text)
                                          .then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (value.statusCode == 200) {
                                          debugPrint("LoginResp ${value.body}");
                                          showDialogWidget(context);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      ' ${value.statusCode} An Error Occurred. Try again Later')));
                                        }
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please fill in all fields"),
                                      ));
                                    }
                                  },
                                  child: const Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    primary: Colors.amber,
                                  ),
                                ),
                              )
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}

// Future<void> register(BuildContext context,
//     bool _isLoading,
//     TextEditingController _controllerfName,
//     TextEditingController _controllerEmail,
//     TextEditingController _controllerPhone,
//     TextEditingController _controllerPassword,) async {
//   if (_controllerfName.text.isNotEmpty && _controllerEmail.text.isNotEmpty &&
//       _controllerPhone.text.isNotEmpty) {
//     var deviceName = "test_device";
//
//     if (registerResponse.statusCode == 200) {
//       _isLoading = false;
//       debugPrint("LoginResp ${registerResponse.body}");
//       showDialogWidget(context);
//     } else {
//       _isLoading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Error!!")));
//     }
//   } else {
//     _isLoading = false;
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text("Please fill in all fields"),
//     ));
//   }
// }

showDialogWidget(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    title: const Text("Info"),
    content: const Text(
        "Thank you for your interest in our service. We will contact you with more details!"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Text("OK"),
        style: TextButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            primary: Colors.white),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
