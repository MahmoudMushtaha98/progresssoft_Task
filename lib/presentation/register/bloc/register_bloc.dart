import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:progresssoft_task/presentation/model/register_model.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  RegisterBloc() : super(RegisterInitial()) {
    on<StartEvent>((event, emit) {
      emit(LoadingState());
      _phoneValidation(event.registerModel);
    });

    on<FailedEvent>((event, emit) async {
      emit(FailedState(event.error));
      print('====================================${event.error}');
    });

    on<OTPSentEvent>((event, emit) async {
      emit(OTPSentState(event.otp));
      _registerFireStore(event.otp);
    });
  }

  void _phoneValidation(RegisterModel registerModel) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: registerModel.phone,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          add(FailedEvent(error.code));
        },
        codeSent: (verificationId, forceResendingToken) {
          add(OTPSentEvent(verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      add(FailedEvent(e.toString()));
    }
  }

  void _registerFireStore(String otp) {
    print('============================$otp');
  }
}
