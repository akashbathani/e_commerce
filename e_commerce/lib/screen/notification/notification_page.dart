import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.white, size: 18),
        ),
        backgroundColor: AppColor.mainColor,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: mTextStyle18(
            mFontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "No Notification yet..!!",
          style: mTextStyle20(mFontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
