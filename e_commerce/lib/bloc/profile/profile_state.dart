import 'package:e_commerce/model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profileModel;
  ProfileLoadedState({required this.profileModel});
}

class ProfileFailureState extends ProfileState {
  final String errorMsg;
  ProfileFailureState({required this.errorMsg});
}
