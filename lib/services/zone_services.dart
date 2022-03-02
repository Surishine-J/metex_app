import 'dart:convert';
import 'dart:io';

import 'package:metex_app/models/api_error.dart';
import 'package:metex_app/models/api_respose.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:metex_app/models/zone_models.dart';

class ZoneServices {

 Future getDataZone() async {
    var response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/zone/all'),
    );
    if (response.statusCode == 200) {
      final ZoneModel zoneModel =
          ZoneModel.fromJson(convert.jsonDecode(response.body));
     /* setState(() {
        location = zoneModel.data;
      });*/
    } else {
      print('Error');
    }
  }

  
}
