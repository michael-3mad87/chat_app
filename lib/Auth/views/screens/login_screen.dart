import 'package:chat_app/Auth/view_model/cubit/auth_cubit.dart';
import 'package:chat_app/Auth/views/screens/register_screen.dart';
import 'package:chat_app/shared/loading_indicator.dart';
import 'package:chat_app/shared/show_message.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/custom_button.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/shared/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
        title:const Text(
          ' Login',
          
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
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      LoadingIndicator.show(context);
                    } else if (state is LoginSuccess) {
                      LoadingIndicator.hide(context);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    } else if (state is LoginError) {
                       LoadingIndicator.hide(context);
                      showToastMessage(state.message);
                    }
                  },
                  child: CustomButton(
                    label: 'Login',
                    oppressed: login,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
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
      BlocProvider.of<AuthCubit>(context).login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
