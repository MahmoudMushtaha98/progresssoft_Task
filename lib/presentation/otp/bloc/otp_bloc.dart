import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:progresssoft_task/presentation/model/credential_model.dart';

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
  }

  void _signInCredential(CredentialModel credentialModel) async {
    try {
      await _auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: credentialModel.verificationId,
          smsCode: credentialModel.smsCode));
      add(OTPValidateEvent());
    } catch (e) {
      if(e is FirebaseAuthException){
        print('=======================================${e.code}');
      }
    }
  }
}
