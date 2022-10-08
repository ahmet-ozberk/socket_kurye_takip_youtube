import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {
  double? lat;
  double? lon;
  int? orderId;
  DataModel({
    this.lat,
    this.lon,
    this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': lon,
      'orderId': orderId,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      lat: map['lat'] != null ? map['lat'] as double : 0.0,
      lon: map['long'] != null ? map['long'] as double : 0.0,
      orderId: map['orderId'] != null ? map['orderId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
