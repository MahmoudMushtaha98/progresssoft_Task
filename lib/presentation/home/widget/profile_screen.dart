import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/login/login_screen.dart';
import 'package:progresssoft_task/presentation/model/register_model.dart';
import '../../widget/data_row.dart';

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
                backgroundColor: const Color(0xffD9D9D9),
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
                        colors: [Color(0xff737373), Color(0xffD9D9D9)]),
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
                      type: 'Name: ',
                    ),
                    DataRowWidget(
                      text: registerModel.phone,
                      type: 'Phone: ',
                    ),
                    DataRowWidget(
                      text: registerModel.date,
                      type: 'Date: ',
                    ),
                    DataRowWidget(
                      text: registerModel.gender,
                      type: 'Gender: ',
                    ),
                    const DataRowWidget(
                      text: '*******',
                      type: 'Password: ',
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
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
