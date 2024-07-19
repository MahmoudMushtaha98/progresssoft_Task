import 'package:flutter/material.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/login/login_screen.dart';

import 'otp widget/otp_text_field.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  static const String pageRoute = '/otp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height(context) * 0.3,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OTPTextField(),
                OTPTextField(),
                OTPTextField(),
                OTPTextField(),
              ],
            ),
            SizedBox(
              height: height(context) * 0.3,
            ),
            SizedBox(
              width: width(context)*0.8,
              height: height(context)*0.06,
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.pageRoute, (route) => false,);
              }, child: Text('Confirm',style: TextStyle(color: Colors.white,fontSize: height(context)*0.02),)),
            )
          ],
        ),
      ),
    );
  }
}
