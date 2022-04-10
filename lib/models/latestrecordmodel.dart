class LatestRecordModel {
  LatestRecordModel({
    required this.data,
  });
  final LatestRecord data;

  factory LatestRecordModel.fromJson(Map<String, dynamic> json){
    final data = LatestRecord.fromJson(json['data']);
    return LatestRecordModel(data: data);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class LatestRecord {
  LatestRecord({
    required this.id,
    required this.ignition,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.voltage,
    required this.iDate,
    required this.iTime,
    required this.extBatt,
  });
  final int id;
  final String ignition;
  final String latitude;
  final String longitude;
  final String speed;
  final String voltage;
  final String iDate;
  final String iTime;
  final String extBatt;

  factory LatestRecord.fromJson(Map<String, dynamic> json){
    final id = json['id'] as int;
    final ignition = json['ignition'] as String;
    final latitude = json['latitude'] as String;
    final longitude = json['longitude'] as String;
    final speed = json['speed'] as String;
    final voltage = json['voltage'] as String;
    final iDate = json['i_date'] as String;
    final iTime = json['i_time'] as String;
    final extBatt = json['ext_batt'] as String;
    return LatestRecord(id: id, ignition: ignition, latitude: latitude, longitude: longitude, speed: speed, voltage: voltage, iDate: iDate, iTime: iTime, extBatt: extBatt);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ignition'] = ignition;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['speed'] = speed;
    _data['voltage'] = voltage;
    _data['i_date'] = iDate;
    _data['i_time'] = iTime;
    _data['ext_batt'] = extBatt;
    return _data;
  }
}