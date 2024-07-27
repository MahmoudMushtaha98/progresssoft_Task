import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utills/model/register_model.dart';


part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final firestore = FirebaseFirestore.instance;

  LoginBloc() : super(LoginInitial()) {
    on<StartLogInEvent>((event, emit) async {
      emit(LoadingState());
      await _signIn(event.phone, event.pass);
    });

    on<SuccessfullyEvent>((event, emit) async {
      await _sharedSave(event.registerModel);
      emit(SuccessfullyState(event.registerModel));
    });

    on<LogInFailed>((event, emit) {
      emit(FailedState());
    });
  }

  Future<void> _signIn(String phone, String pass) async {
    try {
      QuerySnapshot<Map<String, dynamic>> user = await firestore
          .collection('User')
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: pass)
          .get()
          .then(
        (value) {
          return value;
        },
      );

      if (user.docs.isNotEmpty) {
        add(SuccessfullyEvent(RegisterModel(
            user.docs.first['name'],
            user.docs.first['phone'],
            user.docs.first['date'],
            user.docs.first['gender'],
            user.docs.first['password'],
            null)));
      } else {
        add(LogInFailed('Phone Number Or Password Not Correct'));
      }
    } catch (e) {
      add(LogInFailed(e.toString()));
    }
  }

  Future<void> _sharedSave(RegisterModel r) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('data',
          '{"name":"${r.fulName}","phone":"${r.phone}","date":"${r.date}","gender":"${r.gender}","password":"${r.password}"}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
