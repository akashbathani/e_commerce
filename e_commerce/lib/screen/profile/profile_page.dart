import 'package:e_commerce/bloc/profile/profile_bloc.dart';
import 'package:e_commerce/bloc/profile/profile_event.dart';
import 'package:e_commerce/bloc/profile/profile_state.dart';
import 'package:e_commerce/screen/profile/order_page.dart';
import 'package:e_commerce/screen/profile/profile_edit_page.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // Start: upar
              end: Alignment.bottomCenter, // Stop: neeche
              colors: [AppColor.mainColor.withOpacity(0.7), AppColor.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  PRFOILE
                profileCard(),
                SizedBox(height: 20),
                // ORDER
                orderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileCard() {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        }

        if (state is ProfileFailureState) {
          isLoading = false;
          AppSnackbar.showError(context, state.errorMsg);
        }

        if (state is ProfileLoadedState) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        }
        if (state is ProfileFailureState) {
          return Center(child: Text(state.errorMsg));
        }
        if (state is ProfileLoadedState) {
          final profile = state.profileModel.data;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: mTextStyle20(mFontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // PROFILE CARD
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.mainColor,
                        maxRadius: 25,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile!.name!,
                            style: mTextStyle16(mFontWeight: FontWeight.bold),
                          ),
                          Text(profile.email!, style: mTextStyle14()),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileEditPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget orderWidget() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state is ProfileLoadedState) {
              final userId = state.profileModel.data!.id!;
              // print(
              //   "===> USER ID : ${state.profileModel.data!.id!}",
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(userId: userId),
                ),
              );
            }
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "My Order",
                    style: mTextStyle18(mFontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
