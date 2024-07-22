import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/home/navigator.dart';
import 'package:progresssoft_task/presentation/login/bloc/login_bloc.dart';
import 'package:progresssoft_task/presentation/login/login_screen.dart';
import 'package:progresssoft_task/presentation/otp/bloc/otp_bloc.dart';
import 'package:progresssoft_task/presentation/otp/otp_screen.dart';
import 'package:progresssoft_task/presentation/register/bloc/register_bloc.dart';
import 'package:progresssoft_task/presentation/register/register_screen.dart';
import 'package:progresssoft_task/presentation/splash/bloc/splash_bloc.dart';
import 'package:progresssoft_task/presentation/splash/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(3),
                  backgroundColor: WidgetStatePropertyAll(Color(0xff003466)),
                  textStyle:
                      WidgetStatePropertyAll(TextStyle(color: Colors.white)),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  )))),
      debugShowCheckedModeBanner: false,
      routes: {
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
        NavigatorScreen.pageRoute: (context) => BlocProvider(
              create: (context) => HomeBloc(),
              child: const NavigatorScreen(),
            ),
      },
    );
  }
}
