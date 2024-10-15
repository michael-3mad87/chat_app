import 'package:chat_app/Auth/views/screens/register_screen.dart';
import 'package:chat_app/Auth/view_model/user_provider.dart';
import 'package:chat_app/app_them.dart';
import 'package:chat_app/Auth/views/widgets/custom_button.dart';
import 'package:chat_app/Auth/data/data_source/firebase_function.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/Auth/views/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          ' Login',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.white,
              ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'email can not be less than 5 character';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  isPassword: true,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 character';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  label: 'Login',
                  oppressed: login,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                  child: Text("Don't have an account ?",
                      style: TextStyle(color: AppTheme.primaryColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        final user = await FirebaseFunctions.login(
          email: emailController.text,
          password: passwordController.text,
        );

        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } catch (error) {
       
        String? message;
        if (error is FirebaseAuthException) {
          message = error.message;
        } else {
          message = "Something went wrong";
        }
        Fluttertoast.showToast(
          msg: message ?? "Something wrong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red,
          textColor: AppTheme.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
