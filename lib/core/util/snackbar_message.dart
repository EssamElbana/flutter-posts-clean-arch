import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) =>
      _showSnackBar(message, context, Colors.green);

  void showErrorSnackBar(
      {required String message, required BuildContext context}) =>
    _showSnackBar(message, context, Colors.red);

  void _showSnackBar(
      String message, BuildContext context, MaterialColor backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
    ));
  }
}
