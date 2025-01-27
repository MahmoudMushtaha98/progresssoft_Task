part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class StartEvent extends RegisterEvent {
  final RegisterModel registerModel;

  StartEvent(this.registerModel);
}

class FailedEvent extends RegisterEvent {
  final String error;

  FailedEvent(this.error);
}

class OTPSentEvent extends RegisterEvent {
  final RegisterModel registerModel;

  OTPSentEvent(this.registerModel);
}

class RegisterSuccessfullyEvent extends RegisterEvent {
  final String verificationId;

  RegisterSuccessfullyEvent(this.verificationId);
}

class CountryCodeEvent extends RegisterEvent {}

class CountryCodeSuccessfullyEvent extends RegisterEvent {
  final String countryCode;

  CountryCodeSuccessfullyEvent(this.countryCode);
}
