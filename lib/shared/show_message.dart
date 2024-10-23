import 'package:chat_app/shared/app_them.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.primaryColor,
    textColor: AppTheme.white,
    fontSize: 16.0,
  );
}
