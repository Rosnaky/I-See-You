import 'package:ISeeYou/src/screens/home_screen.dart';
import 'package:ISeeYou/src/screens/login_screen.dart';
import 'package:ISeeYou/src/screens/register_screen.dart';
import 'package:ISeeYou/src/utils/theme.dart';
import 'package:flutter/material.dart';

class ISeeYou extends StatelessWidget {
  const ISeeYou({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISeeYou',
      theme: myTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
