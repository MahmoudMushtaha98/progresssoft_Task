import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/constant/my_color.dart';
import 'package:progresssoft_task/presentation/home/bottom_navigation_bar_screen.dart';
import 'package:progresssoft_task/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../register/register_screen.dart';
import '../widget/custom_button_widget.dart';
import '../widget/text_form_widget.dart';

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
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessfullyState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavigationBarScreen.pageRoute,
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
                        text: '${AppLocalizations.of(context)!.welcomeTo}\n',
                        style: TextStyle(fontSize: width(context) * 0.1),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!.progressSoft,
                              style: const TextStyle(
                                  color: progressColor,
                                  fontWeight: FontWeight.bold))
                        ])),
                SizedBox(
                  height: height(context) * 0.08,
                ),
                TextFormFieldWidget(
                  label: AppLocalizations.of(context)!.mobileNumber,
                  textInputType: TextInputType.phone,
                  controller: phone,
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                TextFormFieldWidget(
                  label: AppLocalizations.of(context)!.password,
                  obscureText: true,
                  controller: password,
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                CustomButtonWidget(
                  callback: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(StartLogInEvent(phone.text, password.text));
                  },
                  text: AppLocalizations.of(context)!.login,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.pageRoute);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.register,
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
