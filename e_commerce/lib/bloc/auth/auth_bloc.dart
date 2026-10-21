import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/login_model.dart';
import 'package:e_commerce/model/signup_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiService apiService;
  AuthBloc({required this.apiService}) : super(AuthInitialState()) {
    // USER LOGIN

    on<UserLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        var data = await apiService.postApi(
          url: AppUrl.URL_LOGIN,
          mBodyoarams: {
            "email": event.loginResModel.email,
            "password": event.loginResModel.password,
          },
        );
        LoginModel res = LoginModel.fromJson(data);
        if (res.status == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", res.tokan!);
          emit(LoginSuccessState());
        } else {
          emit(
            LoginFailureState(
              errorMsg: res.message ?? "Invalid email or password.",
            ),
          );
        }
      } catch (e) {
        emit(LoginFailureState(errorMsg: e.toString()));
      }
    });

    // FOR USER REGISTRATION
    on<UserRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        var data = await apiService.postApi(
          url: AppUrl.URL_SIGNUP,
          mBodyoarams: event.signUpReqModel.toJson(),
        );
        SignUpModel res = SignUpModel.fromJson(data);
        if (res.status == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", res.token!);
          emit(RegisterSuccessState());
        } else {
          emit(
            RegisterFailureState(
              errorMsg: res.message ?? "Registeration failed.",
            ),
          );
        }
      } catch (e) {
        emit(RegisterFailureState(errorMsg: e.toString()));
      }
    });
  }
}
