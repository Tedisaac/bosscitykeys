import 'package:bosscitykeys/constants/strings.dart';
import 'package:bosscitykeys/models/latestrecordmodel.dart';
import 'package:bosscitykeys/pages/mappage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;

import '../utils/AppLog.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var data;
  var model = '...';
  var regNo = '...';
  var chasisNo = '...';
  var modelYear = '...';
  late Data latestRecord;

  Future<Data> getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Strings.token);
    var carId = prefs.getString(Strings.id);
    model = prefs.getString(Strings.model) ?? '';
    regNo = prefs.getString(Strings.regNo) ?? '';
    chasisNo = prefs.getString(Strings.chasisNo) ?? '';
    modelYear = prefs.getString(Strings.year) ?? '';
    var newUrl = Strings.cars_list + "/$carId/records/latest";
    var client = http.Client();
    var detailsResponse = await client.get(Uri.parse(newUrl),
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    var detailsData = cnv.jsonDecode(detailsResponse.body);
    data = detailsData['data'];
    latestRecord = Data.fromJson(data);
    AppLog.e(latestRecord.longitude.toString(), tag: "response body");
    if (detailsResponse.statusCode == 200) {
      return latestRecord;
    } else {
      return latestRecord;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        backgroundColor: Colors.amber,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Container(
      color: Colors.amberAccent,
      child: Container(
        color: Colors.amberAccent,
        child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<Data> snapshot) {
              if (snapshot.data == null) {
                return const SpinKitCircle(color: Colors.white);
              } else {
                var ignition = snapshot.data?.ignition ?? '...';
                var speed = snapshot.data?.speed ?? '...';
                var voltage = snapshot.data?.voltage ?? '...';
                var iDate = snapshot.data?.timestamp ?? '';
                var extBatt = snapshot.data?.extBatt ?? '';
                var dateTime = "$iDate" as String;
                var speedKm = "$speed Km/Hr";
                var one = 1;
                return Container(
                    color: Colors.amberAccent,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/sedan.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Model",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  model,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/plate.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Registration Number",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  regNo,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/barcode.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Chasis Number",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  modelYear,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/calendar.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Manufacture Year",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  chasisNo,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/time.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  dateTime,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/deadline.png'),
                                            width: 50,
                                            height: 45,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Speed",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  speedKm,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/pow.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Status",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                if (ignition ==
                                                    one.toString()) ...[
                                                  const Text(
                                                    "Online",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green),
                                                  ),
                                                ] else ...[
                                                  const Text(
                                                    "Offline",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/voltage.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  'Voltage',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  voltage.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 0.0),
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                                'assets/images/lighting.png'),
                                            width: 50,
                                            height: 30,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 17.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "External Battery",
                                                  style:
                                                      TextStyle(fontSize: 20.0),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                if (extBatt ==
                                                    one.toString()) ...[
                                                  const Text(
                                                    "Attached",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green),
                                                  ),
                                                ] else ...[
                                                  const Text(
                                                    "Dettached",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10, right: 16),
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  // var latitude = '1.00' ;
                                  // var longitude = '37.00';
                                  var latitude = snapshot.data?.latitude ?? '';
                                  var longitude =
                                      snapshot.data?.longitude ?? '';
                                  saveLocation(context, latitude, longitude);
                                },
                                label: const Text('Locate in Map',
                                    style: TextStyle(color: Colors.black)),
                                icon: const Icon(
                                  CupertinoIcons.location,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.amber,
                              ),
                            ))
                      ],
                    ));
              }
            }),
      ),
    );
  }
}

Future<void> saveLocation(
    BuildContext context, var latitude, var longitude) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(Strings.latitude, latitude);
  await prefs.setDouble(Strings.longitude, longitude);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const MapPage()));
}

class Details {
  final String id,
      ignition,
      latitude,
      longitude,
      speed,
      voltage,
      iTime,
      iDate,
      extBatt;

  Details(this.id, this.ignition, this.latitude, this.longitude, this.speed,
      this.voltage, this.iDate, this.iTime, this.extBatt);
}
