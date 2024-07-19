import 'package:flutter/material.dart';
import 'package:progresssoft_task/constant/diriction.dart';

import '../register/register_screen.dart';
import '../widget/text_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String pageRoute = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: height(context) * 0.1,
            ),
            Image.asset('assets/images/logo.png'),
            SizedBox(
              height: height(context) * 0.02,
            ),
            Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text: 'Welcom To\n',
                    style: TextStyle(fontSize: width(context) * 0.1),
                    children: const [
                      TextSpan(
                          text: 'ProgressSoft',
                          style: TextStyle(
                              color: Color(0xff003466),
                              fontWeight: FontWeight.bold))
                    ])),
            SizedBox(
              height: height(context) * 0.08,
            ),
            const TextFormFieldWidget(
              label: 'Mobile Number',
              textInputType: TextInputType.phone,
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            const TextFormFieldWidget(
              label: 'Password',
              obscureText: true,
            ),
            SizedBox(
              height: height(context) * 0.05,
            ),
            SizedBox(
              width: width(context) * 0.8,
              height: height(context) * 0.05,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontSize: height(context) * 0.02),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RegisterScreen.pageRoute);
              },
              child: Text(
                'Register',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: height(context) * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
