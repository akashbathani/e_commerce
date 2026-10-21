import 'package:e_commerce/screen/cart_page.dart';
import 'package:e_commerce/screen/dashboard.dart';
import 'package:e_commerce/screen/favourite_page.dart';
import 'package:e_commerce/screen/home_page.dart';
import 'package:e_commerce/screen/profile/profile_page.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int selectedIndex = 0;
  List<Widget> screens = [
    DashboardPage(),
    FavouritePage(),
    HomePage(),
    CartPage(cartId: "2"),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        onPressed: () {
          setState(() {
            selectedIndex = 2;
          });
        },
        child: Image.asset(
          "asset/image/home.png",
          height: 20,
          color: AppColor.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: AppColor.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Image.asset("asset/image/dashboard.png", height: 22),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },

                child: Image.asset("asset/image/heart.png", height: 22),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
                child: Image.asset("asset/image/trolley.png", height: 22),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                },
                child: Image.asset("asset/image/user.png", height: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
