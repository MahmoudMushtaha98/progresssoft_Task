part of 'my_app_bloc.dart';

@immutable
sealed class MyAppState {}

final class MyAppInitial extends MyAppState {}

class ChangeLanguageState extends MyAppState {
  final String countryCode;

  ChangeLanguageState(this.countryCode);
}
