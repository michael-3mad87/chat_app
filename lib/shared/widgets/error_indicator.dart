import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  const ErrorIndicator({super.key, this.message = 'SomeThing went Wrong'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.red,
            ),
      ),
    );
  }
}
