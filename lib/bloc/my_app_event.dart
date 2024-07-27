part of 'my_app_bloc.dart';

@immutable
sealed class MyAppEvent {}

class ChangeLanguageEvent extends MyAppEvent {
  final String languageCode;

  ChangeLanguageEvent(this.languageCode);
}
