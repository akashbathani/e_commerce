import 'package:e_commerce/model/login_res_model.dart';
import 'package:e_commerce/model/signup_request_model.dart';

abstract class AuthEvent {}

class UserLoginEvent extends AuthEvent {
  final LoginResModel loginResModel;

  UserLoginEvent({required this.loginResModel});
}

class UserRegisterEvent extends AuthEvent {
  final SignupRequestModel signUpReqModel;

  UserRegisterEvent({required this.signUpReqModel});
}
