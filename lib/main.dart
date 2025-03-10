import 'package:chat_app/Auth/view_model/cubit/auth_cubit.dart';
import 'package:chat_app/Auth/views/screens/login_screen.dart';
import 'package:chat_app/Auth/views/screens/register_screen.dart';
import 'package:chat_app/chat/views/screen/chat_screen.dart';
import 'package:chat_app/rooms/view/screens/create_room_screen.dart';
import 'package:chat_app/shared/app_bloc_observer.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(),
      child: const ChatApp(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        CreateRoomScreen.routeName: (_) => const CreateRoomScreen(),
        ChatScreen.routeName: (_) => const ChatScreen(),
      },
      initialRoute: LoginScreen.routeName,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}
