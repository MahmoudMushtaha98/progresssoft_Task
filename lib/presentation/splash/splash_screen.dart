import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/home/bottom_navigation_bar_screen.dart';

import '../../utills/model/register_model.dart';
import '../login/login_screen.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String pageRoute = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(FitchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is SuccessfullyState) {
          RegisterModel registerModel = RegisterModel(
              jsonDecode(state.data)['name'],
              jsonDecode(state.data)['phone'],
              jsonDecode(state.data)['date'],
              jsonDecode(state.data)['gender'],
              jsonDecode(state.data)['password'],
              null);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavigationBarScreen.pageRoute,
            arguments: registerModel,
            (route) => false,
          );
        } else if (state is FirstVisitState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.pageRoute,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(width(context) * 0.05),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ProgressSoft-Logo.png'))),
          child: Text(
            '© 2024 ProgressSoft Corporation. All rights reserved.',
            style: TextStyle(fontSize: height(context) * 0.015),
          ),
        ),
      ),
    );
  }
}
