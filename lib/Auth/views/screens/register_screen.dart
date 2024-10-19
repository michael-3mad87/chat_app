import 'package:chat_app/Auth/view_model/cubit/auth_cubit.dart';
import 'package:chat_app/Auth/views/screens/login_screen.dart';
import 'package:chat_app/shared/loading_indicator.dart';
import 'package:chat_app/shared/show_message.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/custom_button.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/shared/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.white,
        ),
        title: Text(
          'Create Account',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.white,
              ),
        ),
        backgroundColor: Colors.transparent,
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
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return 'Name can not be less than 3 character';
                    }
                    return null;
                  },
                ),
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
                    if (state is RegisterLoading) {
                      LoadingIndicator.show(context);
                    } else if (state is RegisterSuccess) {
                      LoadingIndicator.hide(context);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    } else if (state is RegisterError) {
                      LoadingIndicator.hide(context);
                      showToastMessage(state.message);
                    }
                  },
                  child: CustomButton(
                    label: 'Create Account',
                    oppressed: register,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text(
                    'Already have an account',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );
    }
  }
}
