import 'package:http/http.dart' as http;
import '../global/global.dart' as global;
import 'dart:convert';
import '../Traits/get_device_details.dart';
import 'package:flutter/material.dart';

Future<Map> ValidationPassport({String page, String token}) async {
  var device_details = await getDeviceDetails();
  // print(device_details.toString());

  // print('input api validation-passport token :${token}');
  final response_validation_passport = await http.post(
    '${global.url}:${global.port}/api/validation-passport',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'token': token,
      'page': page,
      'os': device_details['os'],
      'identifier': device_details['identifier'],
      'employee_id': global.employee_id.toString()
    }),
  );

  Map json_string_validation_passport =
      jsonDecode(response_validation_passport.body);
  // print(json_string_validation_passport);

  return json_string_validation_passport;
  // return 'asd';
}
