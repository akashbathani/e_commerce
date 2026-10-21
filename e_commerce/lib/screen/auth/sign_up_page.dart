import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/bottomNavBar/bottomNavBar_page.dart';
import 'package:e_commerce/model/signup_request_model.dart';
import 'package:e_commerce/screen/auth/login_page.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey();
  //

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confrimPassController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();

  //
  bool isLoading = false;

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: mq.height * 0.09),
                header(),
                SizedBox(height: mq.height * 0.05),
                Text(
                  "Create Account",
                  style: mTextStyle24(mFontWeight: FontWeight.bold),
                ),
                SizedBox(height: mq.height * 0.03),
                commonTextField(
                  "Full Name",
                  "Enter your name",
                  Icons.person_outline,
                  nameController,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                commonTextField(
                  "Email",
                  "Enter your email",
                  Icons.email_outlined,
                  emailController,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                commonTextField(
                  "Mobile No",
                  "Enter your Mobile No",
                  Icons.call_outlined,
                  mobNoController,
                  (value) {
                    if (value!.isEmpty) {
                      return " Please enter mob no";
                    } else if (value.length < 10) {
                      return "Mob no should be 10";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                commonTextField(
                  "Password",
                  "Enter password",
                  Icons.lock_outline,
                  passController,
                  (value) {
                    if (value!.isEmpty) {
                      return "please enter password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                commonTextField(
                  "Confrim Password",
                  "Confrim password",
                  Icons.lock_outline,
                  confrimPassController,
                  (value) {
                    if (value!.isEmpty) {
                      return "please enter password";
                    } else if (value != passController.text) {
                      return "Password not matched";
                    }
                    return null;
                  },
                ),
                SizedBox(height: mq.height * 0.05),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      isLoading = true;
                      print("==> loading");
                    }

                    if (state is RegisterFailureState) {
                      print("==> failure");

                      isLoading = false;
                      AppSnackbar.showError(context, state.errorMsg);
                    }

                    if (state is RegisterSuccessState) {
                      print("==> Success");

                      isLoading = false;
                      AppSnackbar.showSuccess(context, "Register Successful.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBarPage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return button();
                  },
                ),
                SizedBox(height: mq.height * 0.05),
                showRichtext(),
                SizedBox(height: mq.height * 0.09),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        Center(child: Image.asset("asset/image/logo.png", height: 70)),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              "SHOPPY",
              style: mTextStyle12(
                mFontweight: FontWeight.bold,
                color: AppColor.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonTextField(
    String title,
    String hintTitle,
    IconData icon,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: mTextStyle14(mFontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColor.black),
            hintText: hintTitle,
            hintStyle: TextStyle(color: AppColor.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget button() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.mainColor),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            try {
              context.read<AuthBloc>().add(
                UserRegisterEvent(
                  signUpReqModel: SignupRequestModel(
                    name: nameController.text,
                    email: emailController.text,
                    mobileNumber: mobNoController.text,
                    password: passController.text,
                  ),
                ),
              );
            } catch (e) {
              throw Exception(e.toString());
            }
          }
        },
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(color: AppColor.white),
                ),
              )
            : Text(
                "Create",
                style: mTextStyle18(
                  color: AppColor.white,
                  mFontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget showRichtext() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Already have an account.? ",
              style: TextStyle(color: AppColor.black, fontSize: 14),
            ),
            TextSpan(
              text: " Login",
              style: mTextStyle14(
                color: AppColor.mainColor,
                mFontWeight: FontWeight.bold,
              ),

              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
