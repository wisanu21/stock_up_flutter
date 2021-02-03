import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, String text) {
  return new AlertDialog(
    title: const Text('กรุณาอ่านก่อนดำเนินการ'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${text}"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: Text('Close'),
      ),
    ],
  );
}

