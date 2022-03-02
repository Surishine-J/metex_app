import 'dart:convert';

import 'package:flutter/foundation.dart';



class ZoneModel {
  ZoneModel({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<LocationModel> data;

  //แปลง  Json to Dart
  ZoneModel.fromJson(Map<String, dynamic> json) {
     message = json['message'];
    err = null;
    data = List.from(json['data']).map((e)=>LocationModel.fromJson(e)).toList();
 

    if (json['data'] != null) {
     
      //old version
      // List<LocationModel> data = new List<LocationModel>();

      //new version
      List<LocationModel> data = [];
      json['data'].forEach((v) {
        data.add(new LocationModel.fromJson(v));
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

class LocationModel {
  LocationModel({
    required this.zoneId,
    required this.zoneName,
    required this.zoneOrder,
  });
  late final int zoneId;
  late final String zoneName;
  late final int zoneOrder;

  //แปลง  Json to Dart
  LocationModel.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    zoneOrder = json['zone_order'];
  }

//แปลง  Dart to Json
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['zone_id'] = zoneId;
    _data['zone_name'] = zoneName;
    _data['zone_order'] = zoneOrder;
    return _data;
  }
}
