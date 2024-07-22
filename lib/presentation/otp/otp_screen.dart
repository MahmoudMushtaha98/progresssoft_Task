import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/login/login_screen.dart';
import 'package:progresssoft_task/presentation/model/credential_model.dart';
import 'package:progresssoft_task/presentation/otp/bloc/otp_bloc.dart';

import 'otp widget/otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  static const String pageRoute = '/otp';

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  late final String verificationId;

  @override
  void didChangeDependencies() {
    verificationId = ModalRoute.of(context)?.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.pageRoute,
            (route) => false,
          );
        },
        child: SingleChildScrollView(
          child: BlocConsumer<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is SuccessfullyState) {
                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (con) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        backgroundColor: Colors.black.withOpacity(0.8),
                        content: Container(
                          alignment: Alignment.center,
                          height: height(context) * 0.3,
                          width: width(context) * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Successfully',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width(context) * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height(context) * 0.06,
                              ),
                              SizedBox(
                                width: width(context) * 0.5,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.pageRoute,
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is FailedState) {
                if (state.error.contains('invalid-verification-code')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Not Correct'),
                    ),
                  );
                  controller1.clear();
                  controller2.clear();
                  controller3.clear();
                  controller4.clear();
                  controller5.clear();
                  controller6.clear();
                } else if (state.error.contains('network-request-failed')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Connection Loss'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error Occurred'),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return SizedBox(
                  height: height(context),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: height(context) * 0.3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OTPTextField(
                        controller: controller1,
                      ),
                      OTPTextField(
                        controller: controller2,
                      ),
                      OTPTextField(
                        controller: controller3,
                      ),
                      OTPTextField(
                        controller: controller4,
                      ),
                      OTPTextField(
                        controller: controller5,
                      ),
                      OTPTextField(
                        controller: controller6,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context) * 0.3,
                  ),
                  SizedBox(
                    width: width(context) * 0.8,
                    height: height(context) * 0.06,
                    child: ElevatedButton(
                        onPressed: () {
                          print(verificationId);
                          String smsCode = controller1.text +
                              controller2.text +
                              controller3.text +
                              controller4.text +
                              controller5.text +
                              controller6.text;

                          BlocProvider.of<OtpBloc>(context).add(
                              OTPValidationEvent(
                                  CredentialModel(verificationId, smsCode)));

                          if (state is SuccessfullyState) {
                            print('Successfully');
                            // Navigator.pushReplacementNamed(
                            //     context, LoginScreen.pageRoute);
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height(context) * 0.02),
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
