import 'package:bloc/bloc.dart';
import 'package:chat_app/Auth/data/data_source/remote_data_source.dart';
import 'package:chat_app/Auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  UserModel? currentUser;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      currentUser = await RemoteDataSource.login(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on Exception catch (e) {
      emit(LoginError(e.toString()));
    }


  }
  Future<void> register({
    required String email,
    required String password,
    required String name ,
  }) async {
    emit(RegisterLoading());
    try {
      currentUser = await RemoteDataSource.register(
        name:name ,
        email: email,
        password: password,
      );

      emit(RegisterSuccess());
    } on Exception catch (e) {
      emit(RegisterError(e.toString()));
    }


  }
}
