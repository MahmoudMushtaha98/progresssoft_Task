import 'package:flutter/material.dart';

import '../../constant/diriction.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.label,
    this.obscureText,
    this.textInputType,
    this.controller,
    this.validator, this.suffixIcon,
  });

  final String? label;
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: height(context) * 0.015),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}
