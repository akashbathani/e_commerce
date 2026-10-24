import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        centerTitle: true,
        title: Text(
          "Dashboard",
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
                "Winter is coming..!!!",
                style: mTextStyle24(mFontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
