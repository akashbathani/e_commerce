import 'package:e_commerce/bloc/profile/profile_event.dart';
import 'package:e_commerce/bloc/profile/profile_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/profile_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ApiService apiService;
  ProfileBloc({required this.apiService}) : super(ProfileInitialState()) {
    on<ProfileFetchEvent>((event, emit) async {
      emit(ProfileLoadingState());

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null || token.isEmpty) {
          emit(ProfileFailureState(errorMsg: "Token is missing or expired"));
        }

        var data = await apiService.postApi(
          url: AppUrl.URL_PROFILE,
          token: token,
        );

        ProfileModel profile = ProfileModel.fromJson(data);

        if (profile.status == true) {
          emit(ProfileLoadedState(profileModel: profile));
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("userId", profile.data!.id.toString());
        } else {
          emit(
            ProfileFailureState(
              errorMsg: profile.message ?? "Profile was not found.",
            ),
          );
        }
      } catch (e) {
        emit(ProfileFailureState(errorMsg: e.toString()));
      }
    });
  }
}
