import 'package:bosscitykeys/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:bosscitykeys/pages/detailspage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:bosscitykeys/models/vehicledatamodel.dart';
import 'dart:convert' as cnv;


class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<VehicleDataModel>? vehicleModel;
  List<dynamic>? body;
  getVehicleData() async{
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var client = http.Client();
    var vehiclesResponse = await client.get(
      Uri.parse(Strings.cars_list),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    if(vehiclesResponse.statusCode == 200){
      var vehicleJsonData = vehiclesResponse.body;
      Map<String, dynamic> map = cnv.jsonDecode(vehicleJsonData);
      var obj = VehicleDataModel.fromJson(map);
      var info = obj.data;
      info!.map((e){
        print(e.id);
      }).toList();
      body = map["data"];
      vehicleModel = body!.map((dynamic item) => VehicleDataModel.fromJson(item)).toList();
      print(vehicleModel);
      setState(() {

      });
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Check Your Internet Connection!")));
    }


  }
  static const IconData logout_rounded = IconData(0xf88b, fontFamily: 'MaterialIcons');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getVehicleData(context);
  }
  @override
  Widget build(BuildContext context) {
    getVehicleData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Tracking'),
        backgroundColor: Colors.amber,
        actions: [
          new IconButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage())
                );
              },
              icon: Icon(logout_rounded))
        ],
      ),
      body: Container(
        color: Colors.amberAccent,
        child: FutureBuilder(
          future: getVehicleData(),
          builder: (context, index){
            if(index.data != null){
              return Container(
                child: Center(
                  child: Text(
                    'Loading...'
                  ),
                ),
              );
            }else{
              return ListView.builder(
                  itemCount: vehicleModel?.length,
                  //shrinkWrap: true,
                  itemBuilder: (context,index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        body![index]["model"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0
                                        ),
                                      ),
                                      Text(
                                        body![index]["plate_number"],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 18.0
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                child: TextButton(
                                  onPressed: () {
                                    var id = body![index]["id"];
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => DetailsPage(),)
                                    );
                                  },
                                  child: Text('Details'),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      primary: Colors.white
                                  ),
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

