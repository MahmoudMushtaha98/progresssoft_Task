import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/model/register_model.dart';
import 'package:progresssoft_task/presentation/register/bloc/register_bloc.dart';
import 'package:progresssoft_task/presentation/widget/text_form.dart';

import '../otp/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String pageRoute = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  List<String> dropdownList = ['Gender', 'Male', 'Female'];
  String dropdownValue = 'Gender';
  String dateTime = 'dd/mm/yy';

  bool dateTimeValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: BlocProvider(
            create: (context) => RegisterBloc(),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccessfullyStat) {
                  Navigator.pushNamed(context, OTPScreen.pageRoute,
                      arguments: state.verificationId);
                }
              },
              builder: (context, state) {
                if (state is LoadingState || state is OTPSentState) {
                  return SizedBox(
                    height: height(context),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is FailedState) {
                  SnackBar(content: Text(state.error));
                }
                return Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.1,
                    ),
                    TextFormFieldWidget(
                      label: 'full name',
                      controller: fullName,
                      validator: (p0) => nameValidator(p0),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    TextFormFieldWidget(
                      label: 'mobile number',
                      textInputType: TextInputType.phone,
                      controller: phone,
                      validator: (p0) => phoneValidator(p0),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            minTime: DateTime(1950, 1, 1),
                            maxTime: DateTime(2020, 12, 30), onChanged: (date) {
                          dateTime = date.toString();
                        }, onConfirm: (date) {
                          setState(() {
                            dateTime = '${date.day}/${date.month}/${date.year}';
                            dateTimeValid = true;
                          });
                        }, locale: LocaleType.en);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: width(context) * 0.03),
                        alignment: Alignment.centerLeft,
                        width: width(context) * 0.9,
                        height: height(context) * 0.055,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          dateTime,
                          style: TextStyle(
                              color: dateTimeValid
                                  ? Colors.black
                                  : Colors.black45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.03),
                      alignment: Alignment.centerLeft,
                      width: width(context) * 0.9,
                      height: height(context) * 0.055,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        style: TextStyle(
                            color: dropdownValue == dropdownList.first
                                ? Colors.black54
                                : Colors.black),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: dropdownList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    TextFormFieldWidget(
                      label: 'Password',
                      obscureText: true,
                      controller: password,
                      validator: (p0) => passwordValidator(p0),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    TextFormFieldWidget(
                      label: 'Confirm password',
                      obscureText: true,
                      controller: confirmPassword,
                      validator: (p0) => confirmPasswordValidator(p0),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    SizedBox(
                      width: width(context) * 0.8,
                      height: height(context) * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate() &&
                              !dateTime.contains('dd/mm/yy') &&
                              dropdownValue != dropdownList.first) {
                            BlocProvider.of<RegisterBloc>(context).add(
                                StartEvent(RegisterModel(
                                    fullName.text,
                                    phone.text,
                                    dateTime.toString(),
                                    dropdownValue,
                                    password.text,
                                    null)));
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height(context) * 0.02),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? nameValidator(String? name) {
    final fullNameRegExp = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)+$");
    if (name == null || name.isEmpty) {
      return 'Enter your name';
    } else if (fullNameRegExp.hasMatch(name)) {
      return null;
    } else {
      return '';
    }
  }

  String? phoneValidator(String? phone) {
    final phoneNumberRegExp = RegExp(r"^\+9627\d{8}$");
    if (phone == null || phone.isEmpty) {
      return 'Enter your number';
    } else if (phoneNumberRegExp.hasMatch(phone)) {
      return null;
    } else {
      return '';
    }
  }

  String? passwordValidator(String? password) {
    final passwordRegExp = RegExp(r"^.{6,}$");

    if (password == null || password.isEmpty) {
      return 'Enter your password';
    } else if (passwordRegExp.hasMatch(password)) {
      return null;
    } else if (password.length < 6) {
      return 'Minimum 6 diets';
    } else {
      return '';
    }
  }

  String? confirmPasswordValidator(String? confirmPassword) {
    if (confirmPassword != password.text) {
      return 'not match';
    } else {
      return null;
    }
  }
}
