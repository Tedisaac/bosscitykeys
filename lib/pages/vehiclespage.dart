import 'dart:io' show Platform, exit;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bosscitykeys/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:bosscitykeys/pages/detailspage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:bosscitykeys/models/vehicledatamodel.dart';
import 'dart:convert' as cnv;
import 'package:shared_preferences/shared_preferences.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<Data> data = [];

  Future<List<Data>> getVehicleData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(Strings.token);
    var client = http.Client();
    var vehiclesResponse = await client.get(
      Uri.parse(Strings.cars_list),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    var vehiclesData = cnv.jsonDecode(vehiclesResponse.body);
    var details = vehiclesData['data'];
    if (vehiclesResponse.statusCode == 200) {
      if(data.isNotEmpty){
        data.clear();
      }
      for (Map<String, dynamic> i in details) {
        data.add(Data.fromJson(i));
      }
      return data;
    } else {
      return data;
    }
  }

  static const IconData logout_rounded =
      IconData(0xf88b, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Vehicle Tracking'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: Icon(
                                    CupertinoIcons.exclamationmark,
                                    color: Colors.red,
                                  )),
                              Text('Do you want to Logout?'),
                              SizedBox(
                                height: 10,
                              ),
                              OutlinedButton(
                                  onPressed: () async {
                                    clearData(context);
                                    logout(context);
                                  },
                                  child: Text('OK'))
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(logout_rounded))
        ],
      ),
      body: Container(
        color: Colors.amberAccent,
        child: FutureBuilder(
          future: getVehicleData(),
          builder: (context, AsyncSnapshot<List<Data>> snapshot) {
            if (snapshot.data == null) {
              return SpinKitCircle(color: Colors.white);
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.0, vertical: 5.0),
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            snapshot.data![index].model
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          )),
                                      Text(
                                        snapshot.data![index].plateNumber,
                                        style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 16.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: TextButton(
                                  onPressed: () {
                                    var id =
                                        snapshot.data![index].id.toString();
                                    var model =
                                        snapshot.data![index].model.toString();
                                    var regNo = snapshot
                                        .data![index].plateNumber
                                        .toString();
                                    var year = snapshot.data![index].modelYear
                                        .toString();
                                    var chasisNo = snapshot
                                        .data![index].chasisNumber
                                        .toString();
                                    saveCarData(context, id, model, regNo, year,
                                        chasisNo);
                                  },
                                  child: const Text('Details'),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      primary: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(Strings.isLoggedIn, false);

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}

void clearData(BuildContext context) async {
  final preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

Future<void> saveCarData(BuildContext context, var id, var model, var regNo,
    var chasisNo, var year) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id);
  await prefs.setString('model', model);
  await prefs.setString('reg_no', regNo);
  await prefs.setString('year', year);
  await prefs.setString('chasis_no', chasisNo);
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const DetailsPage(),
  ));
}

onBackPressed(BuildContext context) {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}
