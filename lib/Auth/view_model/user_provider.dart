import 'package:chat_app/Auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }
}
