import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      elevation: 5,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(29),
      child: Container(
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: branco,
          borderRadius: BorderRadius.circular(29),
        ),
        child: child,
      ),
    );
  }
}
