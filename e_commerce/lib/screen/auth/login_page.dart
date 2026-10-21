import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/bottomNavBar/bottomNavBar_page.dart';
import 'package:e_commerce/model/login_res_model.dart';
import 'package:e_commerce/screen/auth/sign_up_page.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // CONTROLLER
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey();

  // EMAIL REGEX
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // PASSWORD OBSECURE
  bool isPasswordVisible = false;

  // MANAGE STATE
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Center(child: Image.asset("asset/image/logo.png", height: 70)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "SHOPPY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 2),
                commonTextField(
                  "Email",
                  "Enter your email",
                  emailController,
                  Icons.email_outlined,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                commonTextField(
                  "Password",
                  "Enter your password",
                  passController,
                  Icons.lock_outline,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                loginButton(),
                SizedBox(height: 40),
                showRichText(),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonTextField(
    String label,
    String hintTitle,
    TextEditingController controller,
    IconData icon,
    String? Function(String?)? validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: mTextStyle16(
            color: AppColor.black,
            mFontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: mq.height * 0.01),
        TextFormField(
          style: mTextStyle14(),
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColor.black),
            hintText: hintTitle,
            hintStyle: mTextStyle14(),
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

  Widget loginButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is LoginSuccessState) {
          setState(() {
            isLoading = false;
          });
          AppSnackbar.showSuccess(context, "Login Successful");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarPage()),
          );
        } else if (state is LoginFailureState) {
          setState(() {
            isLoading = false;
          });
          AppSnackbar.showError(context, state.errorMsg.toString());
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  UserLoginEvent(
                    loginResModel: LoginResModel(
                      email: emailController.text,
                      password: passController.text,
                    ),
                  ),
                );
              }
            },
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Text(
                    "Login",
                    style: mTextStyle18(
                      color: AppColor.white,
                      mFontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget showRichText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "Don't have an account.? ", style: mTextStyle14()),
            TextSpan(
              text: "Create one...",
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
