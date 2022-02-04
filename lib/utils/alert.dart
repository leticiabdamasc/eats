import 'dart:async';

import 'package:eats/utils/nav.dart';
import 'package:flutter/material.dart';

alert(BuildContext contextDialog, String title, String msg, String button,
    {Function? callback}) {
  showDialog(
    context: contextDialog,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(60),
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 16.0, color: Colors.black),
        ),
        content: const Icon(
          Icons.check_circle_outline_outlined,
          size: 60,
          color: Colors.green,
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.white,
            elevation: 0,
            onPressed: () {
              pop(context);
            },
            child: Text(
              button,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontSize: 15.0, color: Colors.black),
            ),
          )
        ],
      );
    },
  );
}

confirm(BuildContext context, String title, String msg, String button,
    {Function? callback}) {
  alert(context, title, msg, button).then((value) {
    Timer timer = Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
    timer.cancel();
  });
}
