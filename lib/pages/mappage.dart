import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  static LatLng _center = const LatLng(45.222222,-122.6777);
  Set<Marker> _marker = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }
  void setCustomMarker() async{
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        'assets/images/marker.png');
  }
  _onMapCreated(GoogleMapController controller){
    _googleMapController.complete(controller);
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(45.222222,-122.6777),
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
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 24.0
              ),
              mapType: _currentMapType,
              markers: _marker,
              onCameraMove: _onCameraMove,
            ),
            Padding(
                padding: EdgeInsets.all(16.0),
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
            )
          ],
        )
    );
  }

}
