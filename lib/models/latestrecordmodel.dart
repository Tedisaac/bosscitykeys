class LatestRecordModel {
  LatestRecord? data;

  LatestRecordModel({this.data});

  LatestRecordModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LatestRecord.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LatestRecord {
  int? id;
  String? ignition;
  String? latitude;
  String? longitude;
  String? speed;
  String? voltage;
  String? iDate;
  String? iTime;
  String? extBatt;

  LatestRecord({this.id,
    this.ignition,
    this.latitude,
    this.longitude,
    this.speed,
    this.voltage,
    this.iDate,
    this.iTime,
    this.extBatt});

  LatestRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    ignition = json['ignition'] as String;
    latitude = json['latitude'] as String;
    longitude = json['longitude'] as String;
    speed = json['speed'] as String;
    voltage = json['voltage'] as String;
    iDate = json['i_date'] as String;
    iTime = json['i_time'] as String;
    extBatt = json['ext_batt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ignition'] = this.ignition;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['speed'] = this.speed;
    data['voltage'] = this.voltage;
    data['i_date'] = this.iDate;
    data['i_time'] = this.iTime;
    data['ext_batt'] = this.extBatt;
    return data;
  }
}