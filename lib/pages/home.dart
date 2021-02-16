import 'package:flutter/material.dart';
import 'package:stock_up_flutter/pages/register.dart';
import 'package:stock_up_flutter/pages/login.dart';
import 'package:stock_up_flutter/pages/dashboard.dart';

import 'dart:convert';
import '../global/global.dart' as global;
import 'package:http/http.dart' as http;
import '../Traits/get_device_details.dart';
import '../Traits/passpor_to_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stock UP'),
        ),
        body: Builder(
            builder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 300,
                          width: 300,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'images/loading.gif',
                            image:
                                '${global.url}:${global.port}/api/image/app/stock.jpg',
                          )),
                      Container(
                        height: 10,
                      ),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          var device_details = await getDeviceDetails();
                          // print(device_details);
                          final response_login_by_device_id = await http.post(
                            '${global.url}:${global.port}/api/login-by-device-id',
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'os': device_details['os'],
                              'identifier': device_details['identifier'],
                            }),
                          );
                          Map json_string_response_login_by_device_id =
                              jsonDecode(response_login_by_device_id.body);

                          print(json_string_response_login_by_device_id);
                          int employee_id = null;
                          String device_token = null;

                          if (json_string_response_login_by_device_id[
                                  'state'] ==
                              'successfully') {
                            // เคยใช้อุปกรเข้าระบบแล้ว
                            employee_id =
                                json_string_response_login_by_device_id[
                                    'employee_id'];
                            device_token =
                                json_string_response_login_by_device_id[
                                    'token'];
                          } else {
                            // login by text_phone , text_password
                            final response_login = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => login(),
                              ),
                            );

                            if (response_login != null) {
                              employee_id = response_login['employee_id'];
                              device_token = response_login['token'];
                            }
                          }
                          // print('-----response_login : ${device_token}');
                          global.employee_id = employee_id;
                          global.device_token = device_token;
                          if (global.employee_id != null) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => dashboard(),
                                // builder: (context) => PassporToPage(
                                //     next_page: 'dashboard',
                                //     next_widget: dashboard()),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      FlatButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Colors.white,
                        onPressed: () async {
                          final string_detail_successfully =
                              await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => register(),
                            ),
                          );
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       global.buildPopupDialog(context, 'test'),
                          // );
                          // Navigator.of(context).pop();
                          if (string_detail_successfully != null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('${string_detail_successfully}'),
                              // backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text(
                          "สมัครสมาชิก",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
