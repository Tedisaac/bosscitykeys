import 'package:bosscitykeys/pages/mappage.dart';
import 'package:flutter/material.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details'
        ),
        backgroundColor: Colors.amber,
      ),
      body: getBody()
      );
  }
  Widget getBody(){
    return Container(
      color: Colors.amberAccent,
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
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
                      child: Image.asset('assets/images/car.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "Vehicle Type",
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "Mazda",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
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
            height: 80,
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
                      child: Image.asset('assets/images/licence.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Registration Number",
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "KCL 261Q",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
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
            height: 80,
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
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Model Number",
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "1938y5860595g",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
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
            height: 80,
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
                      child: Image.asset('assets/images/year.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Manufacture Year",
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "2006",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
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
            height: 80,
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
                      child: Image.asset('assets/images/odometer.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Mileage",
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "3002",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
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
            padding: EdgeInsets.symmetric(
              vertical: 25.0,
            ),
            width: 300.0,
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MapPage())
                );
              },
              child: Text("Locate in Map"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(15),
                primary: Colors.amber,
              ),
            ),
          )
        ],
      ),
    );
  }
}
