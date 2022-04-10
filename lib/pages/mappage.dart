import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var lat,long;
  Completer<GoogleMapController> _googleMapController = Completer();
  LatLng _center = LatLng(0.0, 0.0);
  Set<Marker> _marker = {};
  LatLng _lastMapPosition = LatLng(0.0, 0.0);
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;
  late Uint8List markerIcon;
  getLocation() async{
    final prefs = await SharedPreferences.getInstance();
    var latitude = prefs.getString('latitude');
    var longitude = prefs.getString('longitude');
    lat = double.parse(latitude!);
    long = double.parse(longitude!);
    print(latitude);
    print(longitude);
    setState(() {
      _center = LatLng(lat, long);
      _lastMapPosition = _center;
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
    getLocation();
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
          position: LatLng(lat,long),
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
    return Container(
      height: 40.0,
      width: 40.0,
      child: FloatingActionButton(
        onPressed: func,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.amberAccent,
        child: Icon(iconData,size: 25.0,),
      ),
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
          target: LatLng(lat,long),
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
      //button(_vehiclePower, Icons.power)
    ],
    ),
    ),
    ),
    ],
    )
    );
  }
}
