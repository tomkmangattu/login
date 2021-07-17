import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'mobileauth_state.dart';

class MobileauthCubit extends Cubit<MobileauthState> {
  final String phoneNo;
  late final String _verificationId;
  bool _signInStarted = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileauthCubit({required this.phoneNo}) : super(MobileauthInitial()) {
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    emit(MobileauthLoading());
    final String no = '+91' + phoneNo;

    final PhoneVerificationCompleted _verificationCompleted =
        (PhoneAuthCredential credential) {
      _signInStarted = true;
      try {
        _auth.signInWithCredential(credential);
      } catch (e) {
        emit(
          MobileauthError(
              error:
                  'Sorry SomeThing went wrong please try again after some time'),
        );
      }
      emit(MobileauthSucess());
    };

    final PhoneVerificationFailed _verificationFailed =
        (FirebaseAuthException e) {
      late final String error;
      if (e.code == 'invalid-phone-number') {
        error = 'The provided phone number is not valid.';
      } else {
        error = 'Sorry SomeThing went wrong please try again after some time';
      }

      emit(MobileauthError(error: error));
    };

    final PhoneCodeSent _phoneCodeSent =
        (String verificationId, int? resendToken) async {
      _verificationId = verificationId;
      await Future.delayed(const Duration(seconds: 15));
      if (!_signInStarted) {
        emit(MobileauthOtpSend());
      }
    };

    final PhoneCodeAutoRetrievalTimeout _autoRetrievalTimeOut =
        (String verificationId) {
      if (state is MobileauthSucess) {
      } else {
        emit(MobileauthError(error: 'Sorry TimeOut'));
      }
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: no,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _phoneCodeSent,
      codeAutoRetrievalTimeout: _autoRetrievalTimeOut,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> signInWithPhoneNo(String otp) async {
    emit(MobileauthLoading());

    try {
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(authCredential);
    } on FirebaseException catch (_) {
      emit(
        MobileauthError(
            error: 'Sorry Something went wrong try after some time'),
      );
      return;
    }
    emit(MobileauthSucess());
  }
}
