import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key key,
    this.text,
    this.color,
    this.height = 50,
  }) : super(key: key);

  final String text;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      child: Text(text),
    );
  }
}
