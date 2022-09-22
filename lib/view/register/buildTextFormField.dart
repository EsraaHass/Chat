import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  String text;

  TextEditingController controller;

  String messageError;

  BuildTextFormField(this.text, this.controller, this.messageError);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      style: Theme.of(context).textTheme.bodySmall,
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return messageError;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(fontSize: 14, color: Color(0xFF797979))),
    );
  }
}
