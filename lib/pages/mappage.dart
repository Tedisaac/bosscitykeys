import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:bosscitykeys/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bosscitykeys/pages/playback.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var lat,long;
  Completer<GoogleMapController> _googleMapController = Completer();
  LatLng _center = const LatLng(0.0, 0.0);
  Set<Marker> _marker = {};
  LatLng _lastMapPosition = const LatLng(0.0, 0.0);
  MapType _currentMapType = MapType.normal;
  late BitmapDescriptor mapMarker;
  late Uint8List markerIcon;
  Future<LatLng> getLocation() async{
    final prefs = await SharedPreferences.getInstance();
    var latitude = prefs.getDouble(Strings.latitude);
    var longitude = prefs.getDouble(Strings.longitude);
    lat = latitude!;
    long = longitude!;

    LatLng latLng = LatLng(lat, long);
    setState(() {
      _center = LatLng(lat, long);
      _lastMapPosition = _center;
    });

    return latLng;
  }

  late CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    setCustomMarker();
  }
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
  void setCustomMarker() async{
    markerIcon = (await getBytesFromAsset('assets/images/marker.png', 50))!;
    mapMarker = await BitmapDescriptor.fromBytes(markerIcon);
  }
  _onMapCreated(GoogleMapController controller){
    _googleMapController.complete(controller);
    setState(() {
      _marker.add(
        Marker(
          markerId: const MarkerId('id-1'),
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

  Future<void> moveCamera() async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _center, zoom: 18.0)));
  }

  _onMyLocationPressed(){
    setState(() {
      moveCamera();
    });
  }

  Widget button(VoidCallback func,IconData iconData){
    return SizedBox(
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

  Widget showPlayBackIcon(CalendarController _calendarController) {
    return Container(
      margin: const EdgeInsets.only(right: 3.0),
      child: IconButton(
          onPressed: () {
            showPlayBackDialog(context, _calendarController);
          },
          icon: Image.asset(
            'assets/images/playback.png',
            color: Colors.black,
            width: 20.0,
            height: 20.0,
          )),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          backgroundColor: Colors.amber,
          actions: [
            showPlayBackIcon(_calendarController),
          ],
        ),
        body: Container(
          color: Colors.amberAccent,
          child: FutureBuilder(
              future: getLocation(),
              builder: (context, AsyncSnapshot<LatLng> snashot){
                if(snashot.data != null){
                  return Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child:  GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(snashot.data!.latitude,snashot.data!.longitude!),
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
                              const SizedBox(height: 20.0,),
                              button(_onMyLocationPressed, Icons.my_location)
                              //button(_vehiclePower, Icons.power)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }else {
                  return const SpinKitCircle(
                      color: Colors.white
                  );
                }
              }),
        )
    );
  }
}
showPlayBackDialog(
    BuildContext context, CalendarController _calendarController) {
  int _value = 1;
  var selectedDate;
  AlertDialog dialog = AlertDialog(
    title: const Text("Choose Playback Day"),
    content: Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.white),
      child: TableCalendar(
        initialCalendarFormat: CalendarFormat.month,
        calendarStyle: const CalendarStyle(
            todayColor: Colors.amberAccent,
            selectedColor: Colors.amber,
            todayStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white)),
        headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonDecoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(20.0)),
            formatButtonTextStyle: const TextStyle(color: Colors.white),
            formatButtonShowsNext: false),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (date, events, _) {
          selectedDate = date;
        },
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        calendarController: _calendarController,
      ),
    ),
    actions: [
      Row(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          TextButton(
            onPressed: () async {
              String formattedDate;
              if(selectedDate == null){
                DateTime now = DateTime.now();
                formattedDate = DateFormat('yyyy-MM-dd').format(now);
              }else{
                formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
              }
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(Strings.startDate, formattedDate.toString());
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PlayBack())
            ).then((result) => Navigator.pop(context));
            },
            child: const Text("Show"),
            style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.white),
          ),
          const SizedBox(
            width: 30.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
            style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.white),
          ),
        ],
      ),
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return dialog;
  });
}
