class Playbackrecordsmodel {
  Playbackrecordsmodel({
    required this.data,
  });
  late final List<Data> data;

  Playbackrecordsmodel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    this.ignition,
    required this.latitude,
    required this.longitude,
    this.speed,
    this.voltage,
    this.timestamp,
    this.extBatt,
  });
  late final int id;
  late final Null ignition;
  late final double latitude;
  late final double longitude;
  late final Null speed;
  late final Null voltage;
  late final Null timestamp;
  late final Null extBatt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    ignition = null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    speed = null;
    voltage = null;
    timestamp = null;
    extBatt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ignition'] = ignition;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['speed'] = speed;
    _data['voltage'] = voltage;
    _data['timestamp'] = timestamp;
    _data['ext_batt'] = extBatt;
    return _data;
  }
}