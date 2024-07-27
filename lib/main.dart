import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/bloc/my_app_bloc.dart';
import 'constant/app_route.dart';
import 'constant/build_theme_data.dart';
import 'constant/initialize_my_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await initializeMyApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String countryCode = 'en';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppBloc(),
      child: BlocListener<MyAppBloc, MyAppState>(
        listener: (context, state) {
          if (state is ChangeLanguageState) {
            setState(() {
              countryCode = state.countryCode;
            });
          }
        },
        child: MaterialApp(
          theme: buildThemeData(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(countryCode),
          debugShowCheckedModeBanner: false,
          routes: routes(),
        ),
      ),
    );
  }
}
