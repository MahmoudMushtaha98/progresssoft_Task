import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';

import '../login/login_screen.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String pageRoute = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      SplashBloc()
        ..add(StartSplash()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (BuildContext context, SplashState state) {
          if (state is SplashLoaded) {
            Timer(const Duration(seconds: 2), () =>
                Navigator.of(context).pushReplacementNamed(
                    LoginScreen.pageRoute),);
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
                '© 2024 ProgressSoft Corporation. All rights reserved.',style: TextStyle(fontSize: height(context)*0.015),),
          ),
        ),
      ),
    );
  }
}
