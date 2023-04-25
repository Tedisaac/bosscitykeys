// To parse this JSON data, do
//
//     final latestrecordmodel = latestrecordmodelFromJson(jsonString);

import 'dart:convert';

Latestrecordmodel latestrecordmodelFromJson(String str) => Latestrecordmodel.fromJson(json.decode(str));

String latestrecordmodelToJson(Latestrecordmodel data) => json.encode(data.toJson());

class Latestrecordmodel {
  Latestrecordmodel({
    required this.data,
  });

  Data data;

  factory Latestrecordmodel.fromJson(Map<String, dynamic> json) => Latestrecordmodel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.ignition,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.voltage,
    this.timestamp,
    required this.extBatt,
  });

  int id;
  String ignition;
  double latitude;
  double longitude;
  String speed;
  String voltage;
  dynamic timestamp;
  String extBatt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    ignition: json["ignition"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    speed: json["speed"],
    voltage: json["voltage"],
    timestamp: json["timestamp"],
    extBatt: json["ext_batt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ignition": ignition,
    "latitude": latitude,
    "longitude": longitude,
    "speed": speed,
    "voltage": voltage,
    "timestamp": timestamp,
    "ext_batt": extBatt,
  };
}