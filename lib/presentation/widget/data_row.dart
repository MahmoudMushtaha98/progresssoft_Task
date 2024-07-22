
import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  const DataRowWidget({
    super.key,
    required this.text,
    required this.type,
  });

  final String text;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(type)),
        const SizedBox(
          width: 10,
        ),
        Expanded(flex: 4, child: Text(text)),
      ],
    );
  }
}
