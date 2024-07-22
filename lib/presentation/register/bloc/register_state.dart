part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class LoadingState extends RegisterState {}

class FailedState extends RegisterState {
  final String error;

  FailedState(this.error);
}

class OTPSentState extends RegisterState {
  final String verificationId;

  OTPSentState(this.verificationId);
}

class RegisterSuccessfullyStat extends RegisterState {
  final String verificationId;

  RegisterSuccessfullyStat(this.verificationId);
}

class CountryCodeLoadingState extends RegisterState {}

class CountryCodeSuccessfullyState extends RegisterState {
  final String countryCode;

  CountryCodeSuccessfullyState(this.countryCode);
}
