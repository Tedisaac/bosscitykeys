import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlayBack extends StatefulWidget {
  const PlayBack({Key? key}) : super(key: key);

  @override
  State<PlayBack> createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  double lat = 1.2921;
  double long = 36.8219;
  double lat2 = 1.2675;
  double long2 = 36.8120;
  Completer<GoogleMapController> _googleMapController = Completer();
  LatLng _center = LatLng(1.2921, 36.8219);
  Set<Marker> _marker = {};
  Set<Polyline> _polyline = {};
  List<LatLng> latlngSegment1 = [];
  static LatLng _lat1 = LatLng(1.2921, 36.8219);
  static LatLng _lat2 = LatLng(1.2675, 36.8120);
  LatLng _lastMapPosition = LatLng(1.2921, 36.8219);
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;
  late BitmapDescriptor mapMarker1;
  late Uint8List markerIcon;
  late Uint8List markerIcon1;

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
  void setCustomMarker1() async{
    markerIcon1 = (await getBytesFromAsset('assets/images/placeholder.png', 100))!;
    mapMarker1 = await BitmapDescriptor.fromBytes(markerIcon1);
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
      _marker.add(
        Marker(
          markerId: MarkerId('id-2'),
          position: LatLng(lat2,long2),
          icon: mapMarker1,
        ),
      );
      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 2,
        color: Colors.amber,
      ));
    });
  }
  _onCameraMove(CameraPosition position){
    _lastMapPosition = _center;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
    setCustomMarker1();
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playback"),
        backgroundColor: Colors.amber,

      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14.0
        ),
        mapType: _currentMapType,
        markers: _marker,
        polylines: _polyline,
        onCameraMove: _onCameraMove,
      ),
    );
  }
}

