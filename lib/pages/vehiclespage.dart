import 'package:flutter/material.dart';
import 'package:bosscitykeys/pages/detailspage.dart';

import 'loginpage.dart';


class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List vehicleName = ["Toyota Premio","Mercedes Benz","Jeep","Volvo","Nissan"];
  List vehicleRegistrationNo = ["KAE 234R","KDC 343D","KCF 067D","KDG 657H","KAA 000A"];
  static const IconData logout_rounded = IconData(0xf88b, fontFamily: 'MaterialIcons');


  @override

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
            itemCount: 5,
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
                                  vehicleName[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0
                                  ),
                                ),
                                Text(
                                  vehicleRegistrationNo[index],
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
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => DetailsPage())
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
            }),
      ),
    );
  }
}
