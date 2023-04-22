import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  late CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
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
    markerIcon = (await getBytesFromAsset('assets/images/marker.png', 50))!;
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

  Widget showPlayBackIcon(CalendarController _calendarController) {
    return IconButton(
        onPressed: () {
          showPlayBackDialog(context, _calendarController);
        },
        icon: Image.asset(
          'assets/images/playback.png',
          color: Colors.white,
          width: 20.0,
          height: 20.0,
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.amber,
          actions: [
            showPlayBackIcon(_calendarController),
          ],
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
showPlayBackDialog(
    BuildContext context, CalendarController _calendarController) {
  int _value = 1;
  var selectedDate;
  AlertDialog dialog = AlertDialog(
    title: Text("Choose Playback Day"),
    content: Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.white),
      child: TableCalendar(
        initialCalendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
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
            formatButtonTextStyle: TextStyle(color: Colors.white),
            formatButtonShowsNext: false),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (date, events, _) {
          selectedDate = date;
          print(selectedDate);
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
              style: TextStyle(color: Colors.white),
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        calendarController: _calendarController,
      ),
    ),
    actions: [
      Row(
        children: [
          SizedBox(
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
              print(formattedDate);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('start_date', formattedDate.toString());
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PlayBack())
            ).then((result) => Navigator.pop(context));
            },
            child: Text("Show"),
            style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.white),
          ),
          SizedBox(
            width: 30.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
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
