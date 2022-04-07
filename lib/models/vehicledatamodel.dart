class VehicleDataModel{
  VehicleDataModel({required this.data});
  final List<Data> data;

  factory VehicleDataModel.fromJson(Map<String, dynamic> json){
    final detailsData = json['data'] as List<dynamic>;
    final data = detailsData != null ? detailsData.map((detailData) => Data.fromJson(detailData)).toList() : <Data>[];
    return VehicleDataModel(data: data);
  }
}

class Data{
  Data({required this.id, required this.model, required this.platenumber, required this.chasisnumber, required this.modelyear});
  final int id;
  final String model;
  final String platenumber;
  final String chasisnumber;
  final String modelyear;

  factory Data.fromJson(Map<String, dynamic> json){
    final id = json['id'] as int;
    final model = json['model'] as String;
    final platenumber = json['plate_number'] as String;
    final chasisnumber = json['chasis_number'] as String;
    final modelyear = json['model_year'] as String;
    return Data(id: id, model: model, platenumber: platenumber, chasisnumber: chasisnumber, modelyear: modelyear);
  }


}