import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  static LatLng _center = const LatLng(-1.265190,36.804771);
  Set<Marker> _marker = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;
  late Uint8List markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
  void setCustomMarker() async{
    markerIcon = (await getBytesFromAsset('assets/images/marker.png', 100))!;
    mapMarker = await BitmapDescriptor.fromBytes(markerIcon);
  }
  _onMapCreated(GoogleMapController controller){
    _googleMapController.complete(controller);
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(-1.265190,36.804771),
          icon: mapMarker,
        ),
      );
    });
  }
  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }
  _onMapTypePressed(){
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }
  _vehiclePower(){

  }

  Widget button(VoidCallback func,IconData iconData){
    return FloatingActionButton(
      onPressed: func,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.amberAccent,
      child: Icon(iconData,size: 30.0,),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.amber,
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child:  GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 18.0
                  ),
                  mapType: _currentMapType,
                  markers: _marker,
                  onCameraMove: _onCameraMove,
                ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 10,
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_onMapTypePressed, Icons.map),
                    SizedBox(height: 20.0,),
                    button(_vehiclePower, Icons.power)
                  ],
                ),
              ),
            ),
            Positioned(
                top: 445,
                left: 0,
                right: 0,
                child:  Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                  width: 10,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset.zero,
                      ),
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: Image(image: AssetImage('assets/images/clock.png'),),
                          ),
                          SizedBox(width: 10,),
                          Text("2022-03-18 14:07:36"),
                          SizedBox(width: 15,),
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.amberAccent
                              ),
                              onPressed: (){},
                              child: Text("stopped"))
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Text("Link"),
                          SizedBox(width: 6,),
                          Container(
                            width: 20,
                            height: 20,
                              child: Image.asset('assets/images/check.png')
                          ),
                          Text("Online"),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Power"),
                          SizedBox(width: 6,),
                          Container(
                              width: 20,
                              height: 20,
                              child: Image.asset('assets/images/low-battery.png')
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Speed"),
                          SizedBox(width: 6,),
                          Text("0km/h"),
                        ],
                      ),
                    ],
                  ),

                ))
          ],
        )
    );
  }

}
