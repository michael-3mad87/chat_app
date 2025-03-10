import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
     this.validator,
    this.isPassword = false,
  });
  TextEditingController controller = TextEditingController();
  final String? hintText;
  final int? maxLines;
  bool isPassword = false;

  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: AppTheme.primaryColor,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppTheme.primaryColor,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: isObscure
                    ?const Icon(
                        Icons.visibility_off_outlined,
                        color: AppTheme.primaryColor,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: AppTheme.primaryColor,
                      ),
              )
            : null,
      ),
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword ? isObscure:false,
    );
  }
}
