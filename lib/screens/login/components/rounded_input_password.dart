import 'package:flutter/material.dart';
import 'package:sheets_clients/screens/login/components/text_field_container.dart';

import '../../../constants.dart';

class RoundedPasswordInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordInput({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      validator: (value) {
        if (value!.length < 6) {
          return "Senha muito curta";
        }
      },
      onChanged: onChanged,
      obscureText: true,
      decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kButtonColor,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.visibility,
            color: kButtonColor,
          )),
    ));
  }
}
