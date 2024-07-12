// lib/main.dart
import 'package:dattingapp_flutter/screeen/ChatScreen.dart';
import 'package:dattingapp_flutter/screeen/LoginScreen.dart';
import 'package:dattingapp_flutter/screeen/RegisterScreen.dart';
import 'package:dattingapp_flutter/screeen/ResetPasswordScreen.dart';
import 'package:dattingapp_flutter/screeen/SplashScreen.dart';
import 'package:dattingapp_flutter/screeen/ProfileScreen.dart';
import 'package:dattingapp_flutter/screeen/TinderingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Doctor App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => WelcomeScreen(),
          // '/': (context) => ProfileScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/reset': (context) => ResetPasswordScreen(),
          '/profile': (context) => ProfileScreen(),
          '/chat': (context) => ChatScreen(),
          // '/conversation': (context) => ConversationScreen(),
          '/tindering': (context) => TinderingScreen(),
        },
      ),
    );
  }
}
