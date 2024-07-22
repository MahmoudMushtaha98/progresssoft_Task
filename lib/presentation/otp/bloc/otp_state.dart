part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

class LoadingState extends OtpState{

}

class SuccessfullyState extends OtpState{}


class FailedState extends OtpState{

  final String error;

  FailedState(this.error);
}
