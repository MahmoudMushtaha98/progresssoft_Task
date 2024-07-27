import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/constant/my_color.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/login/login_screen.dart';
import '../../../utills/model/register_model.dart';
import '../../widget/data_row_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.registerModel});

  final RegisterModel registerModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SuccessfullyState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.pageRoute,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is LogoutState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height(context) * 0.07,
                width: double.infinity,
              ),
              CircleAvatar(
                radius: width(context) * 0.2,
                backgroundColor: displayDataLightColor,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: width(context) * 0.8,
                height: height(context) * 0.4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [displayDataDarkColor, displayDataLightColor]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 3))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DataRowWidget(
                      text: registerModel.fulName,
                      type: '${AppLocalizations.of(context)!.name}: ',
                    ),
                    DataRowWidget(
                      text: registerModel.phone,
                      type: '${AppLocalizations.of(context)!.phone}: ',
                    ),
                    DataRowWidget(
                      text: registerModel.date,
                      type: '${AppLocalizations.of(context)!.date}: ',
                    ),
                    DataRowWidget(
                      text: registerModel.gender,
                      type: '${AppLocalizations.of(context)!.gender}: ',
                    ),
                    DataRowWidget(
                      text: '*******',
                      type: '${AppLocalizations.of(context)!.password}: ',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red)),
                child: Text(
                  AppLocalizations.of(context)!.logout,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
