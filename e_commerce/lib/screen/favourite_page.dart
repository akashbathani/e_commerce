import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        centerTitle: true,
        title: Text(
          "Favourite",
          style: mTextStyle18(
            mFontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stay Tuned..!!!",
                style: mTextStyle24(mFontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
