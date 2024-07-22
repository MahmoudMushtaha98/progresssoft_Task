import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/constant/my_color.dart';
import 'package:progresssoft_task/presentation/home/navigator.dart';
import 'package:progresssoft_task/presentation/login/bloc/login_bloc.dart';

import '../register/register_screen.dart';
import '../widget/text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String pageRoute = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessfullyState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              NavigatorScreen.pageRoute,
              arguments: state.registerModel,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
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
                                  color: progressColor,
                                  fontWeight: FontWeight.bold))
                        ])),
                SizedBox(
                  height: height(context) * 0.08,
                ),
                TextFormFieldWidget(
                  label: 'Mobile Number',
                  textInputType: TextInputType.phone,
                  controller: phone,
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                TextFormFieldWidget(
                  label: 'Password',
                  obscureText: true,
                  controller: password,
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                SizedBox(
                  width: width(context) * 0.8,
                  height: height(context) * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(StartLogInEvent(phone.text, password.text));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: height(context) * 0.02),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.pageRoute);
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
          );
        },
      ),
    );
  }
}
