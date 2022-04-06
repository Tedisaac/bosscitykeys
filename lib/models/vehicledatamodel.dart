class VehicleDataModel {
  List<Data>? data;

  VehicleDataModel({this.data});

  VehicleDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? model;
  String? plateNumber;
  String? chasisNumber;
  String? modelYear;

  Data(
      {this.id,
        this.model,
        this.plateNumber,
        this.chasisNumber,
        this.modelYear});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    plateNumber = json['plate_number'];
    chasisNumber = json['chasis_number'];
    modelYear = json['model_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    data['plate_number'] = this.plateNumber;
    data['chasis_number'] = this.chasisNumber;
    data['model_year'] = this.modelYear;
    return data;
  }
}