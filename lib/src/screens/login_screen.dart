import 'dart:math';

import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/screens/home_screen.dart';
import 'package:ISeeYou/src/screens/register_screen.dart';
import 'package:ISeeYou/src/utils/theme.dart';
import 'package:ISeeYou/src/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            });
          }
          return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Login to I See You',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: myTheme.colorScheme.primary)),
                SizedBox(height: constraints.maxHeight * 0.1),
                Center(
                  child: SizedBox(
                    width: min(constraints.maxWidth * 0.9, 500),
                    child: Container(
                      decoration: BoxDecoration(
                          color: myTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: myTheme.colorScheme.onSurface
                                  .withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFieldInput(
                                hintText: 'Email',
                                controller: _emailController,
                                textInputType: TextInputType.emailAddress),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            TextFieldInput(
                                hintText: "Password",
                                controller: _passwordController,
                                textInputType: TextInputType.visiblePassword,
                                obscureText: true),
                            SizedBox(height: constraints.maxHeight * 0.05),
                            ElevatedButton(
                                onPressed: () {
                                  loginUser();
                                },
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                child: Text("Login ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color:
                                                myTheme.colorScheme.primary))),
                            SizedBox(height: constraints.maxHeight * 0.05),
                            ElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, RegisterScreen.routeName),
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                child: Text("Register ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color:
                                                myTheme.colorScheme.primary))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            );
          }));
        });
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    await Auth()
        .login(email: _emailController.text, password: _passwordController.text)
        .then((res) {
      if (res == "Success") {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res),
          backgroundColor: myTheme.colorScheme.error,
        ));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: myTheme.colorScheme.error,
      ));
    }).whenComplete(() => setState(() {
              _isLoading = false;
            }));
  }
}
