import 'package:flutter/material.dart';

Widget welcome(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Image.asset('assets/journal.png'),
          ),
        ),
        Text('Welcome! Write something cool!', textScaleFactor: 1.3,)
      ],
    ),
  );
}
