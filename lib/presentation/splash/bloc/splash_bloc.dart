import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FitchDataEvent>((event, emit) async {
      await _fitchData();
    });

    on<FitchSuccessfullyEvent>((event, emit) async {
      emit(SuccessfullyState(event.data));
    });

    on<FirstVisitEvent>((event, emit) async {
      emit(FirstVisitState());
    });
  }

  Future<void> _fitchData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      String? data;
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          data = sharedPreferences.getString('data');
          if(data !=null){
            add(FitchSuccessfullyEvent(data!));
          }else{
            add(FirstVisitEvent());
          }

        },
      );
    } catch (e) {
      print(e);
    }
  }
}
