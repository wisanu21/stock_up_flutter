import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:form_validator/form_validator.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../global/global.dart' as global;
import '../Traits/get_device_details.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> _form_login = GlobalKey<FormState>();

  final text_phone = TextEditingController();
  final text_password = TextEditingController();

  void _validate() {
    _form_login.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stock UP'),
        ),
        body: Builder(
            builder: (context) => Form(
                key: _form_login,
                child: Center(
                    child: SingleChildScrollView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        padding: const EdgeInsets.only(top: 50),
                        child: BootstrapContainer(
                          children: [
                            BootstrapRow(height: 80.0, children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-1',
                              ),
                              BootstrapCol(
                                sizes: 'col-10',
                                child: TextFormField(
                                  validator:
                                      ValidationBuilder().phone().build(),
                                  // obscureText: true,
                                  controller: text_phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'เบอร์โทรศัพท์',

                                    // errorText: validate_text_fname ? 'กรุณากรอกชื่อจริง' : null,
                                  ),
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-1',
                              ),
                            ]),
                            BootstrapRow(height: 80.0, children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-1',
                              ),
                              BootstrapCol(
                                sizes: 'col-10',
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  // obscureText: true,
                                  controller: text_password,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'รหัสผ่าน',

                                    // errorText: validate_text_fname ? 'กรุณากรอกชื่อจริง' : null,
                                  ),
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-1',
                              ),
                            ]),
                            BootstrapRow(height: 80.0, children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12',
                                child: FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (_form_login.currentState.validate() ==
                                        true) {
                                      // save
                                      var device_details =
                                          await getDeviceDetails();
                                      final login_response = await http.post(
                                        '${global.url}:${global.port}/api/login',
                                        headers: <String, String>{
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: jsonEncode(<String, String>{
                                          'text_phone': text_phone.text,
                                          'text_password': text_password.text,
                                          'os': device_details['os'],
                                          'identifier':
                                              device_details['identifier']
                                        }),
                                      );

                                      Map json_string_login =
                                          jsonDecode(login_response.body);
                                      // print((jsonString.values.toList())[0]);
                                      // print(json_string_login);
                                      if (json_string_login['state'] ==
                                          'successfully') {
                                        Navigator.pop(
                                            context, json_string_login);
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Login is failed .'),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    }
                                  },
                                  child: Text(
                                    "บันทึก",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ))))));
  }
}
