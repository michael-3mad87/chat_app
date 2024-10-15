import 'package:chat_app/Auth/view_model/user_provider.dart';
import 'package:chat_app/Auth/views/screens/login_screen.dart';
import 'package:chat_app/Auth/views/screens/register_screen.dart';
import 'package:chat_app/app_them.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
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
      },
      initialRoute: LoginScreen.routeName,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}
