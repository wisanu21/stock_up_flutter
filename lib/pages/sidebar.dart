import 'package:flutter/material.dart';
import '../global/global.dart' as global;

sidebar(context, List<dynamic> menu_name_arrs, List<dynamic> menu_id_arrs,
    FadeInImage company_fadeIn_image) {
  var indexs = [
    3,
    2,
    5,
    4,
    8,
  ];
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: company_fadeIn_image,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // ListTile(
        //   title: Text('${menu_name_arr}'),
        //   onTap: () {
        //     // Update the state of the app
        //     // ...
        //     // Then close the drawer
        //     Navigator.pop(context);
        //   },
        // ),
        for (var menu_name_arr in menu_name_arrs)
          ListTile(
            title: Text("${menu_name_arr}"),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
      ],
    ),
    // child: ListView.builder(
    //   itemCount: indexs.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text('${indexs[index]}'),
    //     );
    //   },
    // ),
  );
}
