import 'package:http/http.dart' as http;
import '../global/global.dart' as global;
import 'dart:convert';
import '../Traits/get_device_details.dart';
import '../Traits/build_popup_dialog.dart';
import 'package:flutter/material.dart';

LogOut(context) async {
  Map response = await LogOutPassport();
  if (response['state'] == 'successfully') {
    global.device_token = null;
    global.employee_id = null;
  } else {
    global.device_token = null;
    global.employee_id = null;
  }
  Navigator.pop(context);
}

LogOutPassport() async {
  var device_details = await getDeviceDetails();

  final response_log_out = await http.post(
    '${global.url}:${global.port}/api/logout',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'os': device_details['os'],
      'identifier': device_details['identifier'],
    }),
  );
  // print('asdasdasdasd');
  Map json_string_response_log_out = jsonDecode(response_log_out.body);
  // print(json_string_response_log_out);
  return json_string_response_log_out;
  // if(json_string_response_log_out['state'] == 'successfully' ){}
}
