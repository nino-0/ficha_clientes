import 'package:flutter/material.dart';

import '../../../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color color, textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 5,
      shadowColor: Colors.grey,
      color: kButtonColor,
      borderRadius: BorderRadius.circular(29),
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.07,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: TextButton(
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            style: TextButton.styleFrom(
              backgroundColor: color,
            ),
          ),
        ),
      ),
    );
  }
}
