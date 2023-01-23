import 'package:bosscitykeys/test.dart';
import 'package:flutter/material.dart';
import 'package:bosscitykeys/pages/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // useMaterial3: true,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home:  LoginPage(),

    );
  }
}
