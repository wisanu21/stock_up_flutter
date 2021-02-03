import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
// import 'package:stock_up_flutter/pages/register_select_company.dart';
import 'package:smart_select/smart_select.dart';
import 'dart:convert';
import 'package:form_validator/form_validator.dart';
// import '../choices.dart' as choices;
import '../global/global.dart' as global;
import '../models/company.dart' as model_company;
import 'package:http/http.dart' as http;

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final text_fname = TextEditingController();
  // bool validate_text_fname = false;
  final text_lname = TextEditingController();
  // bool validate_text_lname = false;
  final text_phone = TextEditingController();
  // bool validate_text_phone = false;
  final text_password = TextEditingController();
  // bool validate_text_password = false;
  final text_easy_name = TextEditingController();
  // bool validate_text_easy_name = false;
  String select_company = '';
  Key smart_select;

  List<model_company.Company> allcompanys = [];
  @override
  void initState() {
    super.initState();
    loadData();
    // print('-dd--${text_password.text}');
  }

  loadData() async {
    // final store = await CacheStore.getInstance(
    //   namespace:
    //       'unique_name', // default: null - valid filename used as unique id
    //   policy:
    //       LeastFrequentlyUsedPolicy(), // default: null - will use `LessRecentlyUsedPolicy()`
    //   clearNow: true, // default: false - whether to clean up immediately
    //   fetch: myFetch,
    // ); // default: null - a shortcut of `CacheStore.fetch`);
    // store.fetch = myFetch;
    // File file = await store.getFile('https://www.advice.co.th/pc/get_comp/vga');
    // File file =
    //     await store.getFile('${global.url}/api/get-company-by-is-register');
    // http://127.0.0.1:8000/api/get-company

    final response =
        await http.get('${global.url}/api/get-company-by-is-register');
    final jsonString = jsonDecode(response.body);
    // print(fetchAlbum());
    // print(jsonDecode(response.body));

    // final jsonString = json.decode(file.readAsStringSync());
    print(jsonString);

    setState(() {
      jsonString.forEach((v) {
        final companys = model_company.Company.fromJson(v);
        allcompanys.add(companys);
      });
      // print('--sasd--');
    });
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    _form.currentState.validate();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Builder(
        builder: (context) => Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50),
            child: BootstrapContainer(
              children: [
                const SizedBox(height: 7),
                SmartSelect<String>.single(
                    key: smart_select,
                    title: 'ร้านค้า',
                    placeholder: '-- กรุณาเลือกร้านค้า --',
                    value: select_company,
                    modalValidation: (value) =>
                        value.length > 0 ? null : 'Select at least one',
                    onChange: (state) => setState(() {
                          select_company = state.value;
                          // print(select_company);
                        }),
                    choiceItems: S2Choice.listFrom<String, Map>(
                      // source: choices.smartphones,
                      source: model_company.getCompanys(allcompanys),
                      value: (index, item) => item['id'].toString(),
                      title: (index, item) => item['name'].toString(),
                      group: (index, item) => item['isActive'].toString(),
                    ),
                    // groupEnabled: true,
                    // groupSortBy: S2GroupSort.byCountInDesc(),
                    modalType: S2ModalType.bottomSheet,
                    tileBuilder: (context, state) {
                      return S2Tile(
                        // title: state.titleWidget,
                        title: state.titleWidget,
                        value: state.valueDisplay,
                        onTap: state.showModal,
                        isTwoLine: true,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${global.url}/api/image/app/stock.jpg'),
                        ),
                      );
                    }),
                // Text(SelectCompany()),
                // SelectCompany(),
                BootstrapRow(height: 80.0, children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-6',
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      // obscureText: true,
                      controller: text_fname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่อจริง',

                        // errorText: validate_text_fname ? 'กรุณากรอกชื่อจริง' : null,
                      ),
                    ),
                  ),
                  BootstrapCol(
                    sizes: 'col-6',
                    child: TextFormField(
                      validator: ValidationBuilder()
                          .minLength(1, 'Please enter some text')
                          .build(),
                      // obscureText: true,
                      controller: text_lname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'นามสกุล',
                        // errorText: validate_text_lname ? 'กรุณากรอกนามสกุล' : null,
                      ),
                    ),
                  ),
                ]),
                BootstrapRow(height: 80.0, children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-12',
                    child: TextFormField(
                      validator: ValidationBuilder().phone().build(),
                      // obscureText: true,
                      controller: text_phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'เบอร์โทรศัพท์',
                        // errorText: validate_text_phone ? 'กรุณากรอกเบอร์โทรศัพท์' : null,
                      ),
                    ),
                  ),
                ]),
                BootstrapRow(height: 80.0, children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-12',
                    child: TextFormField(
                      obscureText: true,
                      controller: text_password,
                      validator: ValidationBuilder()
                          .minLength(1, 'Please enter some text')
                          .build(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'รหัสผ่าน',
                        // errorText: validate_text_phone ? 'กรุณากรอกเบอร์โทรศัพท์' : null,
                      ),
                    ),
                  ),
                ]),
                BootstrapRow(height: 80.0, children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-2',
                  ),
                  BootstrapCol(
                    sizes: 'col-8',
                    child: TextFormField(
                      // obscureText: true,
                      controller: text_easy_name,
                      // .regExp( RegExp(r"(\w+)"),'fdg').
                      validator: ValidationBuilder()
                          .minLength(1, 'Please enter some text')
                          .build(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่อเล่น',
                        // errorText: validate_text_phone ? 'กรุณากรอกเบอร์โทรศัพท์' : null,
                      ),
                    ),
                  ),
                  BootstrapCol(
                    sizes: 'col-2',
                  ),
                ]),
                BootstrapRow(height: 80.0, children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-12',
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (select_company == '') {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Select at least one'),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          if (_form.currentState.validate() == true) {
                            // save
                            final response = await http.post(
                              '${global.url}/api/save-register',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'select_company': select_company,
                                'text_fname': text_fname.text,
                                'text_lname': text_lname.text,
                                'text_phone': text_phone.text,
                                'text_password': text_password.text,
                                'text_easy_name': text_easy_name.text
                              }),
                            );

                            Map jsonString = jsonDecode(response.body);
                            print((jsonString["state"]));
                            if (jsonString["state"] == 'error') {
                              if (jsonString["detail"].contains(
                                  "for key 'employees_mobile_unique'")) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('my system is have phone number !'),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('กรุณาตรวจสอบข้อมูล !'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                            if (jsonString["state"] == 'successfully') {
                              String detail_successfully = jsonString["detail"];
                              Navigator.pop(context, detail_successfully);
                            }
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
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _validate;
      //   },
      //   tooltip: 'Next',
      //   child: Icon(Icons.arrow_forward),
      // ),
    );
  }
}
