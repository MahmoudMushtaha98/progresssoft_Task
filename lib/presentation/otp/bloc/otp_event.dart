part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}


class OTPValidationEvent extends OtpEvent{
  final CredentialModel credentialModel;

  OTPValidationEvent(this.credentialModel);
}

class OTPValidateEvent extends OtpEvent{}
