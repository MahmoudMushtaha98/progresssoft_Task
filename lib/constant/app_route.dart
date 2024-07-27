import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/home/bloc/home_bloc.dart';
import '../presentation/home/bottom_navigation_bar_screen.dart';
import '../presentation/login/bloc/login_bloc.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/otp/bloc/otp_bloc.dart';
import '../presentation/otp/otp_screen.dart';
import '../presentation/register/bloc/register_bloc.dart';
import '../presentation/register/register_screen.dart';
import '../presentation/splash/bloc/splash_bloc.dart';
import '../presentation/splash/splash_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    SplashScreen.pageRoute: (context) => BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashScreen(),
        ),
    LoginScreen.pageRoute: (context) => BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginScreen(),
        ),
    RegisterScreen.pageRoute: (context) => BlocProvider(
          create: (context) => RegisterBloc(),
          child: const RegisterScreen(),
        ),
    OTPScreen.pageRoute: (context) => BlocProvider(
          create: (context) => OtpBloc(),
          child: const OTPScreen(),
        ),
    BottomNavigationBarScreen.pageRoute: (context) => BlocProvider(
          create: (context) => HomeBloc(),
          child: const BottomNavigationBarScreen(),
        ),
  };
}
