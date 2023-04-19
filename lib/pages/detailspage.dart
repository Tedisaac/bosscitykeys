import 'package:bosscitykeys/constants/strings.dart';
import 'package:bosscitykeys/models/latestrecordmodel.dart';
import 'package:bosscitykeys/pages/mappage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;


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
  Future<LatestRecord> getData() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var carId = prefs.getString('id');
    model = prefs.getString('model') ?? '';
    print(model);
    regNo = prefs.getString('reg_no') ?? '';
    chasisNo = prefs.getString('chasis_no') ?? '';
    modelYear = prefs.getString('year') ?? '';
    var newUrl = Strings.cars_list+"/$carId/records/latest";
    var client = http.Client();
    var detailsResponse = await client.get(
        Uri.parse(newUrl),
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    var detailsData = cnv.jsonDecode(detailsResponse.body);
    data = detailsData['data'];
    LatestRecord latestRecord = LatestRecord.fromJson(data);
    if(detailsResponse.statusCode == 200){


      //print(data['longitude']);
      //var latitude = prefs.setString('latitude', latestRecord.latitude!);
      //var longitude = prefs.setString('longitude', latestRecord.longitude!);
      return latestRecord;
    }else{
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
        title: Text(
          'Details'
        ),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        backgroundColor: Colors.amber,
      ),

      body: getBody(),


      );
  }
  Widget getBody(){
    return FutureBuilder(
        future: getData(),
        builder: (context,AsyncSnapshot<LatestRecord> snapshot){

          //var id = latestRecord?.id as int;
          var ignition = snapshot.data?.ignition ?? '...';
          var speed =snapshot.data?.speed ?? '...';
          var voltage = snapshot.data?.voltage ?? '...';
          var iDate = snapshot.data?.iDate ?? '...';
          var iTime = snapshot.data?.iTime ?? '...';
          var extBatt = snapshot.data?.extBatt ?? '...';
          var dateTime = "$iDate  $iTime" as String;
          var speedKm = "$speed Km/Hr";
          var one = 1;
          if(ignition == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Stack(children:[
            SingleChildScrollView(
            child: Container(
            color: Colors.amberAccent,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/sedan.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Model",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    model,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/plate.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Registration Number",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    regNo,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/barcode.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Chasis Number",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    modelYear,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/calendar.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Manufacture Year",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    chasisNo,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/time.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    dateTime,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/deadline.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Speed",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    speedKm,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/pow.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  if(ignition == one.toString())...[
                                    Text(
                                      "Online",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green
                                      ),),
                                  ]else...[
                                    Text(
                                      "Offline",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                      ),),
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
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/voltage.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Voltage',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    voltage.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/images/lighting.png'),
                              width: 50,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "External Battery",
                                    style: TextStyle(
                                        fontSize: 20.0
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  if(extBatt == one.toString())...[
                                    Text(
                                      "Attached",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green
                                      ),),
                                  ]else...[
                                    Text(
                                      "Dettached",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                      ),),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     vertical: 25.0,
                  //   ),
                  //   width: 300.0,
                  //   child: ElevatedButton(
                  //     onPressed: (){
                  //
                  //       // saveLocation(context, latitude,longitude);
                  //
                  //     },
                  //     child: Text("Locate in Map"),
                  //     style: ElevatedButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //       padding: EdgeInsets.all(15),
                  //       primary: Colors.amber,
                  //     ),
                  //   ),
                  // ),

                ],
              ),
            ),

          ),
              Align( alignment: Alignment.bottomRight,child: Container(margin: EdgeInsets.only(bottom: 10, right: 16),child: FloatingActionButton.extended(onPressed: () {
                // var latitude = '1.00' ;
                // var longitude = '37.00';
                var latitude = snapshot.data?.latitude ?? '';
                var longitude = snapshot.data?.longitude ?? '';
                saveLocation(context, latitude,longitude);

              }, label: Text('Locate in Map'),
                icon: const Icon(CupertinoIcons.location),
                backgroundColor: Colors.amber,),

              ))
            ]

            );
          }
        });
  }


}

Future<void> saveLocation(BuildContext context, var latitude, var longitude) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('latitude', latitude);
  await prefs.setString('longitude', longitude);
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MapPage())
  );
}
class Details{
  final String id, ignition,latitude, longitude, speed , voltage , iTime, iDate, extBatt;
  Details(this.id,this.ignition,this.latitude,this.longitude,this.speed,this.voltage,
      this.iDate,this.iTime,this.extBatt);
}