import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;

  const TextFormFieldWidget(
      {Key? key,
      required this.name,
      required this.controller,
      required this.multiLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
          decoration: InputDecoration(hintText: name),
          maxLines: multiLines ? 6 : 1,
          minLines: multiLines ? 6 : 1,
        ));
  }
}
