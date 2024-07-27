import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utills/model/register_model.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  RegisterBloc() : super(RegisterInitial()) {

    on<CountryCodeEvent>((event, emit) async{
      emit(CountryCodeLoadingState());
      _gitCountryCode();
    });

    on<CountryCodeSuccessfullyEvent>((event, emit) async{
      emit(CountryCodeSuccessfullyState(event.countryCode));
    });
    
    
    on<StartEvent>((event, emit) async{
      emit(LoadingState());
      await _phoneValidation(event.registerModel);
    });

    on<FailedEvent>((event, emit) {
      emit(FailedState(event.error));
    });

    on<OTPSentEvent>((event, emit) async {
      emit(OTPSentState(event.registerModel.verificationId!));
      await _registerFireStore(event.registerModel);
    });

    on<RegisterSuccessfullyEvent>((event, emit) {
      emit(RegisterSuccessfullyStat(event.verificationId));
    });
  }

  Future<void> _phoneValidation(RegisterModel registerModel) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: registerModel.phone,
        verificationCompleted: (phoneAuthCredential) {
        },
        verificationFailed: (error) {
          add(FailedEvent(error.code));
        },
        codeSent: (verificationId, forceResendingToken) {
          add(OTPSentEvent(RegisterModel(
              registerModel.fulName,
              registerModel.phone,
              registerModel.date,
              registerModel.gender,
              registerModel.password,
              verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(minutes: 2),
      );
    } catch (e) {
      add(FailedEvent(e.toString()));
    }
  }

  Future<void> _registerFireStore(RegisterModel registerModel) async {
    try {
      await _firestore.collection('User').add({
        'name': registerModel.fulName,
        'phone': registerModel.phone,
        'date': registerModel.date,
        'gender': registerModel.gender,
        'password': registerModel.password
      }).then(
        (value) {
          add(RegisterSuccessfullyEvent(registerModel.verificationId!));
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('=========================$e');
      }
    }
  }

  void _gitCountryCode() async{
    try{
      QuerySnapshot countryCode = await _firestore.collection('System configuration').get();
      if(countryCode.docs.isNotEmpty){
        add(CountryCodeSuccessfullyEvent(countryCode.docs.first['country code']));
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
