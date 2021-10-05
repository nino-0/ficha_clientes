import 'package:flutter/material.dart';
import 'package:sheets_clients/screens/login/components/text_field_container.dart';

import '../../../constants.dart';

class RoundedInputText extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputText({
    Key? key,
    this.icon = Icons.person,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value) {
          if (value!.length < 5)
            return "Esse e-mail parece curto demais";
          else if (!value.contains("@")) {
            return "e-mail invalido";
          }
          return null;
        },
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
