import 'package:flutter/material.dart';

import '../../constant/diriction.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.callback,
    required this.text,
  });

  final VoidCallback callback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.8,
      height: height(context) * 0.05,
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          text,
          style:
              TextStyle(color: Colors.white, fontSize: height(context) * 0.02),
        ),
      ),
    );
  }
}
