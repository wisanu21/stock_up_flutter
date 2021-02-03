import 'package:flutter/material.dart';
import '../global/global.dart' as global;
import '../Traits/validation_passpor.dart';

PassporToPage({String next_page, next_widget}) {
  return FutureBuilder<Map>(
      future: ValidationPassport(page: next_page, token: global.device_token),
      builder: (context, AsyncSnapshot<Map> response) {
        if (response.hasData) {
          // print(response.data);
          // print(global.device_token);
          if (response.data['state'] == 'successfully') {
            global.device_token = response.data['token'];
            return next_widget;
          } else {
            return WidgetError();
          }
        } else {
          return WidgetLoad(next_page);
        }
      });
}

WidgetError() {
  return Scaffold(
    appBar: AppBar(
      title: new Text(''),
    ),
    body: Center(child: Text("Error")),
  );
}

WidgetLoad(title_bar) {
  return Scaffold(
    appBar: AppBar(
      title: new Text(title_bar),
    ),
    body: Center(child: CircularProgressIndicator()),
  );
}
