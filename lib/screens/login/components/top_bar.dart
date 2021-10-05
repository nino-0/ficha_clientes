import 'package:flutter/material.dart';

import '../../../constants.dart';

class TopBar extends StatelessWidget {
  final String hintBar;
  const TopBar({
    Key? key,
    required this.size,
    required this.hintBar,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              kButtonColor,
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(size.width * 0.4),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.document_scanner,
              size: size.width * 0.15,
              color: branco,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                hintBar,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: branco,
                    fontSize: size.width * 0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
