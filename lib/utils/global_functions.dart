import 'package:flutter/material.dart';

class GlobalFunctions {
  static final GlobalFunctions _instance = GlobalFunctions._internal();
  GlobalFunctions._internal();
  static GlobalFunctions get instance => _instance;

  Future<void> showMessage(BuildContext context,
      {required String message}) async {
    await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        contentPadding: const EdgeInsets.only(
          bottom: 20.0,
          right: 20,
          left: 20,
        ),
        titlePadding: const EdgeInsets.all(15.0),
        title: Center(
          child: Text(
            'Attention',
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Close',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
