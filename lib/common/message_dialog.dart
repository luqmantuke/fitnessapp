import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

Future<void> messageDialog(
    BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: purpleBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              goRouter.pop();
            },
          ),
        ],
      );
    },
  );
}
