import 'package:flutter/material.dart';

push(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

pop(BuildContext context) {
  return Navigator.pop(context);
}

pushRemove(BuildContext context, Widget page) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false);
}
