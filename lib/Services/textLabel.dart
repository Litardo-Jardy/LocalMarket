import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String title;
  const TextLabel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        width: 300,
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, letterSpacing: 1.5),
          textAlign: TextAlign.start,
        ),
      )
    ]);
  }
}
