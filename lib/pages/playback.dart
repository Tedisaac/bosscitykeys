import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bosscitykeys/models/playbackrecordsmodel.dart';
import 'package:bosscitykeys/models/latlongmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  var data;
  late Data playBackrecords;
  late List<LatLng> list;

  Future<Playbackrecordsmodel> getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var carId = prefs.getString('id');
    var startDate = prefs.getString('start_date');
    var newUrl = Strings.cars_list + "/$carId/records";
    var client = http.Client();
    var detailsResponse = await client.post(
      Uri.parse(newUrl),
      body: ({
        'start_date': startDate,
      }),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    var playbackData = cnv.jsonDecode(detailsResponse.body);
    data = playbackData['data'];
    playBackrecords = Data.fromJson(data);
    if (detailsResponse.statusCode == 200) {
      print(playBackrecords);
      return data;
    } else {
      print(playBackrecords);
      return data;
    }
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
      body: FutureBuilder(
        future: getData(),
        builder: (context,AsyncSnapshot<Playbackrecordsmodel> snapshot){
          _onMapCreated(GoogleMapController controller) {
            _googleMapController.complete(controller);
            for(var i = 0; i <= snapshot.data!.data.length; i++){
              list.add(LatLng(double.parse(snapshot.data!.data[i].latitude), double.parse(snapshot.data!.data[i].longitude)));
            }
            setState(() {
              if(list != null){
                for(var j = 0; j <= list.length; j++){
                  if(j == 1){
                    _marker.add(
                      Marker(
                        markerId: MarkerId('$j'),
                        position: LatLng(double.parse(snapshot.data!.data[j].latitude), double.parse(snapshot.data!.data[j].longitude)),
                        icon: mapMarker,
                      ),
                    );
                  }else{
                    _marker.add(
                      Marker(
                        markerId: MarkerId('$j'),
                        position: LatLng(double.parse(snapshot.data!.data[j].latitude), double.parse(snapshot.data!.data[j].longitude)),
                        icon: mapMarker1,
                      ),
                    );
                  }

                }
                _polyline.add(Polyline(
                  polylineId: PolylineId('line1'),
                  visible: true,
                  points: list,
                  width: 2,
                  color: Colors.amber,
                ));
              }
            });
          }
          return  GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
            mapType: _currentMapType,
            markers: _marker,
            polylines: _polyline,
            onCameraMove: _onCameraMove,
          );
        },
      )
    );
  }
}
