class Vehicledatamodel {
  Vehicledatamodel({
    required this.data,
  });
  late final List<Data> data;

  Vehicledatamodel.fromJson(Map<String, dynamic> json){
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
    required this.model,
    required this.plateNumber,
    required this.chasisNumber,
    required this.modelYear,
  });
  late final int id;
  late final String model;
  late final String plateNumber;
  late final String chasisNumber;
  late final int modelYear;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    model = json['model'];
    plateNumber = json['plate_number'];
    chasisNumber = json['chasis_number'];
    modelYear = json['model_year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['model'] = model;
    _data['plate_number'] = plateNumber;
    _data['chasis_number'] = chasisNumber;
    _data['model_year'] = modelYear;
    return _data;
  }
}