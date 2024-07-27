import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_app_event.dart';

part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(MyAppInitial()) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(ChangeLanguageState(event.languageCode));
    });
  }
}
