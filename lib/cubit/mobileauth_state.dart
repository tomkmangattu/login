part of 'mobileauth_cubit.dart';

@immutable
abstract class MobileauthState {}

class MobileauthInitial extends MobileauthState {}

class MobileauthLoading extends MobileauthState {}

class MobileauthOtpSend extends MobileauthState {}

class MobileauthError extends MobileauthState {
  final String error;
  MobileauthError({required this.error});
}

class MobileauthSucess extends MobileauthState {}
