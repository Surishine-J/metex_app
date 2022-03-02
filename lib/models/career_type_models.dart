import 'dart:convert';

import 'package:flutter/foundation.dart';

class CareerTypeModel {
  CareerTypeModel({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<CareerTypeDataModel> data;

  //แปลง  Json to Dart
  CareerTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    err = null;
    data = List.from(json['data'])
        .map((e) => CareerTypeDataModel.fromJson(e))
        .toList();

    if (json['data'] != null) {
      //old version
      // List<LocationModel> data = new List<LocationModel>();

      //new version
      List<CareerTypeDataModel> data = [];

      // data.add(
      //     CareerTypeDataModel(user_type2_id: 0, user_type2_name: "ทั้งหมด"));
      json['data'].forEach((v) {
        data.add(CareerTypeDataModel.fromJson(v));
      });

      
    }
  }
//แปลง  Dart to Json
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CareerTypeDataModel {
  CareerTypeDataModel({
    required this.user_type2_id,
    required this.user_type2_name,
  });
  late final int user_type2_id;
  late final String user_type2_name;

  //แปลง  Json to Dart
  CareerTypeDataModel.fromJson(Map<String, dynamic> json) {
    user_type2_id = json['user_type2_id'];
    user_type2_name = json['user_type2_name'];
  }

//แปลง  Dart to Json
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_type2_id'] = user_type2_id;
    _data['user_type2_name'] = user_type2_name;

    return _data;
  }
}
