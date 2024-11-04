import 'package:chat_app/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class UIUtils {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child:const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              LoadingIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
