import 'package:flutter/material.dart';

class AppDialog {
  AppDialog._();

  static Future<void> dialog(BuildContext context,
      {Widget? title,
      required String content,
      Function()? action,
      required String confirmText}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                content,
                style: const TextStyle(color: Colors.brown, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(confirmText,
                style: const TextStyle(fontSize: 16.8, color: Colors.red)),
            onPressed: () async {
              Navigator.of(context).pop();
              if (action != null) await action();
            },
          ),
          TextButton(
            child: const Text('Huỷ', style: TextStyle(fontSize: 16.8)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
