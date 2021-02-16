import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:stock_up_flutter/pages/sidebar.dart' as sidebar;
import '../Traits/log_out.dart';
import 'package:http/http.dart' as http;
import '../global/global.dart' as global;
import 'dart:convert';

class dashboard extends StatefulWidget {
  @override
  createState() {
    return dashboardState();
  }
}

class dashboardState extends State<dashboard> {
  @override
  var company_image;
  String full_name = null;
  String level = null;
  var menu_name_arr;
  var menu_id_arr;
  Widget sidebar_w;
  var company_fadeIn_image;
  var employee_fadeIn_image;

  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final response = await http.post(
      // '${globadata_dashboardl.url}/api/get-company-by-employee-id',
      '${global.url}:${global.port}/api/get-data-dashboard',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': global.device_token,
        'employee_id': global.employee_id.toString()
      }),
    );
    // print('object');
    final response_data_dashboard = jsonDecode(response.body);
    final load_data_company_image = null;
    setState(() {
      company_image = load_data_company_image;
      full_name =
          '${response_data_dashboard['employees_first_name']} ${response_data_dashboard['employees_last_name']}';
      level = '${response_data_dashboard["levels_name"]}';
      String companies_path_image =
          '${response_data_dashboard["companies_path_image"]}';
      String employee_path_image =
          '${response_data_dashboard["employees_path_image"]}';
      // print(response_data_dashboard);
      company_fadeIn_image = FadeInImage.assetNetwork(
        placeholder: 'images/loading.gif',
        image:
            '${global.url}:${global.port}/api/image/company/${companies_path_image}',
      );
      employee_fadeIn_image = FadeInImage.assetNetwork(
        placeholder: 'images/loading.gif',
        image:
            '${global.url}:${global.port}/api/image/employee/${employee_path_image}',
      );
      sidebar_w = sidebar.sidebar(
          context,
          response_data_dashboard["arr_name_menu"],
          response_data_dashboard["arr_id_menu"],
          company_fadeIn_image);
    });
  }

  build(BuildContext context) {
    // print(validation_passport['state']);
    return Scaffold(
      appBar: AppBar(title: Text('แผงควบคุม'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.sensor_door_outlined),
          tooltip: 'Next page',
          onPressed: () {
            // Navigator.pop(context);
            LogOut(context);
          },
        )
      ]),
      body: SingleChildScrollView(
          // mainAxisAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.only(top: 50),
          child: BootstrapContainer(
            children: [
              BootstrapRow(height: 320.0, children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          child: employee_fadeIn_image,
                        )
                      ]),
                )
              ]),
              BootstrapRow(height: 10.0, children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Text(
                    '${full_name}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
              BootstrapRow(height: 80.0, children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Text(
                    'ระดับ  ${level}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                )
              ])
            ],
          )),
      // drawer: sidebar.sidebar(context, menu_name_arr, menu_id_arr)
      drawer: sidebar_w,
    );
  }
}
