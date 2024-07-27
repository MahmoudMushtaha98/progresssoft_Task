import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/register/bloc/register_bloc.dart';
import 'package:progresssoft_task/presentation/widget/text_form_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constant/validation.dart';
import '../../utills/model/register_model.dart';
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

  late List<String> dropdownList;
  late String dropdownValue;
  late String dateTime;

  bool dateTimeValid = false;

  @override
  void initState() {
    BlocProvider.of<RegisterBloc>(context).add(CountryCodeEvent());
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    dateTime = AppLocalizations.of(context)!.dateTime;
    dropdownList = [
      AppLocalizations.of(context)!.gender,
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female
    ];
    dropdownValue = AppLocalizations.of(context)!.gender;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessfullyStat) {
                Navigator.pushNamed(context, OTPScreen.pageRoute,
                    arguments: state.verificationId);
              }
              if (state is FailedState) {
                if (state.error.contains('network-request-failed')) {
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
              } else if (state is CountryCodeSuccessfullyState) {
                phone.text = state.countryCode;
              }
            },
            builder: (context, state) {
              if (state is LoadingState ||
                  state is OTPSentState ||
                  state is CountryCodeLoadingState) {
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
                    label: AppLocalizations.of(context)!.fullName,
                    controller: fullName,
                    validator: (p0) => nameValidator(p0?.trim()),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  TextFormFieldWidget(
                    textInputType: TextInputType.phone,
                    controller: phone,
                    validator: (p0) => phoneValidator(p0?.trim()),
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
                            color:
                                dateTimeValid ? Colors.black : Colors.black45),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.03),
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
                    label: AppLocalizations.of(context)!.password,
                    obscureText: true,
                    controller: password,
                    validator: (p0) => passwordValidator(p0?.trim()),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  TextFormFieldWidget(
                    label: AppLocalizations.of(context)!.rePassword,
                    obscureText: true,
                    controller: confirmPassword,
                    validator: (p0) =>
                        confirmPasswordValidator(p0?.trim(), password.text),
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
                          BlocProvider.of<RegisterBloc>(context).add(StartEvent(
                              RegisterModel(
                                  fullName.text.trim(),
                                  phone.text.trim(),
                                  dateTime.toString(),
                                  dropdownValue,
                                  password.text.trim(),
                                  null)));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.register,
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
    );
  }
}
