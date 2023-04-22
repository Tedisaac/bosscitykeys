class Latlongmodel {
  Latlongmodel({
    required this.latitude,
    required this.longitude,
  });
  late final String latitude;
  late final String longitude;

  Latlongmodel.fromJson(Map<String, dynamic> json){
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}