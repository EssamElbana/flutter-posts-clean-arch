import 'package:flutter/material.dart';

class FormSubmitButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdate;

  const FormSubmitButtonWidget(
      {Key? key, required this.onPressed, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdate ? Icons.edit : Icons.add),
      label: Text(isUpdate ? "Update" : "Add"),
    );
  }
}
