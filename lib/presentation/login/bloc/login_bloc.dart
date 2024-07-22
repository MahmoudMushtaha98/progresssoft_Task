import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/register_model.dart';

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
      print(event.error);
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
      print(e);
    }
  }
}
