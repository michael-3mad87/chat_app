import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.oppressed,
    this.width
  });
  final double? width;
  final String label;
  final VoidCallback oppressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: oppressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width?? MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * .06),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 20, color: AppTheme.white),
      ),
    );
  }
}
