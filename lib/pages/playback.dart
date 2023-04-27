import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bosscitykeys/models/playbackrecordsmodel.dart';
import 'package:bosscitykeys/models/latlongmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import '../constants/strings.dart';
import '../utils/AppLog.dart';

class PlayBack extends StatefulWidget {
  const PlayBack({Key? key}) : super(key: key);

  @override
  State<PlayBack> createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  Completer<GoogleMapController> _googleMapController = Completer();
  late LatLng _center;
  Set<Marker> _marker = {};
  Set<Polyline> _polyline = {};
  List<LatLng> latlngSegment1 = [];
  static LatLng _lat1 = LatLng(1.2921, 36.8219);
  static LatLng _lat2 = LatLng(1.2675, 36.8120);
  late LatLng _lastMapPosition;
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;
  late BitmapDescriptor mapMarker1;
  late Uint8List markerIcon;
  late Uint8List markerIcon1;

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  void setCustomMarker() async {
    markerIcon = (await getBytesFromAsset('assets/images/marker.png', 50))!;
    mapMarker = await BitmapDescriptor.fromBytes(markerIcon);
  }

  void setCustomMarker1() async {
    markerIcon1 =
        (await getBytesFromAsset('assets/images/placeholder.png', 50))!;
    mapMarker1 = await BitmapDescriptor.fromBytes(markerIcon1);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = _center;
  }

  var latLongData;
  late Playbackrecordsmodel playBackrecords;
  List<LatLng> list = <LatLng>[];

  Future<Playbackrecordsmodel> getPlayBackData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Strings.token);
    var carId = prefs.getString('id');
    var startDate = prefs.getString('start_date');
    print(startDate);
    var newUrl = Strings.cars_list + "/$carId/records";
    print(newUrl);
    var client = http.Client();
    var detailsResponse = await client.get(
      Uri.parse(newUrl),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    var playbackData = cnv.jsonDecode(detailsResponse.body);
    playBackrecords = Playbackrecordsmodel.fromJson(playbackData);
    if (detailsResponse.statusCode == 200) {
      print(playBackrecords);
      _center = LatLng(playBackrecords.data[0].latitude, playBackrecords.data[0].longitude);
      return playBackrecords;
    } else {
      return playBackrecords;
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    setState(() {
      if(list.isNotEmpty){
        for(var j = 0; j < list.length; j++){
          if(j == 0){
            _marker.add(
              Marker(
                markerId: MarkerId('$j'),
                position: LatLng(list[j].latitude, list[j].longitude),
                icon: mapMarker,
              ),
            );
          }else{
            _marker.add(
              Marker(
                markerId: MarkerId('$j'),
                position: LatLng(list[j].latitude, list[j].longitude),
                icon: mapMarker1,
              ),
            );
          }
        }
        latlngSegment1 = list;
        _polyline.add(Polyline(
          polylineId: PolylineId('line1'),
          visible: true,
          points: latlngSegment1,
          width: 2,
          color: Colors.amber,
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
    setCustomMarker1();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playback"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.amberAccent,
        child: FutureBuilder(
          future: getPlayBackData(),
          builder: (context,AsyncSnapshot<Playbackrecordsmodel> snapshot){
            if(snapshot.data != null){
              for(var i = 0; i < snapshot.data!.data.length; i++){
                list.add(LatLng(snapshot.data!.data[i].latitude, snapshot.data!.data[i].longitude));
              }
              return  GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
                mapType: _currentMapType,
                markers: _marker,
                polylines: _polyline,
                onCameraMove: _onCameraMove,
              );
            } else {
              return SpinKitCircle(
                  color: Colors.white
              );
            }

          },
        ),
      )
    );
  }
}
