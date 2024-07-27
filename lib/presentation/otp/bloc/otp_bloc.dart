import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utills/model/credential_model.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final _auth = FirebaseAuth.instance;

  OtpBloc() : super(OtpInitial()) {
    on<OTPValidationEvent>((event, emit) {
      emit(LoadingState());
      _signInCredential(event.credentialModel);
    });

    on<OTPValidateEvent>((event, emit) {
      emit(SuccessfullyState());
    });

    on<FailedEvent>((event, emit) {
      emit(FailedState(event.error));
    });
  }

  void _signInCredential(CredentialModel credentialModel) async {
    try {
      await _auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: credentialModel.verificationId,
          smsCode: credentialModel.smsCode));
      add(OTPValidateEvent());
    } catch (e) {
      if(e is FirebaseAuthException){
        add(FailedEvent(e.code));
      }
    }
  }
}
