import 'package:flutter/material.dart';

import 'package:sheets_clients/screens/login/components/text_field_container.dart';

import '../../../constants.dart';

class RoundedInputTextGeneric extends StatelessWidget {
  TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  RoundedInputTextGeneric({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kButtonColor,
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
