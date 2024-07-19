
import 'package:flutter/material.dart';

import '../../../constant/diriction.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.15,
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          FocusScope.of(context).nextFocus();

        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}
