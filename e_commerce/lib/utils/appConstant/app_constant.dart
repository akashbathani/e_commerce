import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color mainColor = Colors.deepOrangeAccent;
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
}

late Size mq;
const String TOKEN = "token";

TextStyle mTextStyle12({
  Color color = Colors.black,
  mFontweight = FontWeight.normal,
}) {
  return TextStyle(
    fontWeight: mFontweight,
    fontSize: 12,
    color: color,
    fontFamily: 'mainFont',
  );
}

TextStyle mTextStyle14({
  Color color = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'mainFont',
    fontSize: 14,
    fontWeight: mFontWeight,
  );
}

TextStyle mTextStyle16({
  Color color = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'mainFont',
    fontSize: 16,
    fontWeight: mFontWeight,
  );
}

TextStyle mTextStyle18({
  Color color = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'mainFont',
    fontSize: 18,
    fontWeight: mFontWeight,
  );
}

TextStyle mTextStyle20({
  Color color = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'mainFont',
    fontSize: 20,
    fontWeight: mFontWeight,
  );
}

TextStyle mTextStyle24({
  Color color = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'mainFont',
    fontSize: 24,
    fontWeight: mFontWeight,
  );
}

class AppSnackbar {
  // FOR SUCCESS MESSAGE
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.successColor,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
      ),
    );
  }

  // FOR ERROR MESSAGE
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.errorColor,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
      ),
    );
  }
}
