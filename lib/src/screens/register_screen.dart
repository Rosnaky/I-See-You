import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/providers/user_provider.dart';
import 'package:ISeeYou/src/screens/home_screen.dart';
import 'package:ISeeYou/src/screens/login_screen.dart';
import 'package:ISeeYou/src/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController emergencyPhoneNumber1TextEditingController =
      TextEditingController();
  final TextEditingController emergencyPhoneNumber2TextEditingController =
      TextEditingController();
  final TextEditingController emergencyPhoneNumber3TextEditingController =
      TextEditingController();
  final TextEditingController secretCodeTextEditingController =
      TextEditingController();

  late AnimationController progressController;

  bool _isLoading = false;
  DateTime? _dateOfBirth;
  int _step = 0;

  @override
  void initState() {
    super.initState();

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    progressController.repeat();
  }

  @override
  void dispose() {
    progressController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    emergencyPhoneNumber1TextEditingController.dispose();
    emergencyPhoneNumber2TextEditingController.dispose();
    emergencyPhoneNumber3TextEditingController.dispose();

    _step = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false));
          }
          return Scaffold(
            appBar: AppBar(),
            body: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Register with",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "I See You",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    registerWidget(constraints),
                    _step == 0
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: constraints.maxWidth * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Already have an account?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(fontSize: 14)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 12, 12, 0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: const SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Login"),
                                              ],
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            }),
          );
        });
  }

  Container registerWidget(BoxConstraints constraints) {
    switch (_step) {
      case 0:
        return registerEmailAndPassword(constraints);
      case 1:
        return registerName(constraints);
      case 2:
        return registerPhoneNumbers(constraints);
      default:
        return registerEmailAndPassword(constraints);
    }
  }

  Container registerEmailAndPassword(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    TextFieldInput(
                        controller: emailTextEditingController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: passwordTextEditingController,
                        hintText: "Password",
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: confirmPasswordTextEditingController,
                        hintText: "Confirm Password",
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (passwordTextEditingController.text !=
                            confirmPasswordTextEditingController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _step = 1;
                        });
                      },
                      child: const SizedBox(
                          width: 80,
                          height: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next"),
                            ],
                          )),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container registerName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    TextFieldInput(
                        controller: firstNameTextEditingController,
                        hintText: "First Name",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: lastNameTextEditingController,
                        hintText: "Last Name",
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _step = 0;
                                    });
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Previous"),
                                        ],
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _step = 2;
                                    });
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Next"),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    setState(() {
      _isLoading = true;
    });

    List<String> emergencyContacts = [
      emergencyPhoneNumber1TextEditingController.text
    ];
    if (emergencyPhoneNumber2TextEditingController.text.isNotEmpty) {
      emergencyContacts.add(emergencyPhoneNumber2TextEditingController.text);
    }
    if (emergencyPhoneNumber3TextEditingController.text.isNotEmpty) {
      emergencyContacts.add(emergencyPhoneNumber3TextEditingController.text);
    }

    await Auth()
        .register(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      phoneNumber: phoneNumberTextEditingController.text,
      emergencyContacts: emergencyContacts,
    )
        .then((value) async {
      setState(() {
        _isLoading = false;
      });
      if (value == "Success") {
        await Provider.of<UserProvider>(context, listen: false).refreshUser();
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushNamed(context, HomeScreen.routeName));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(value),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  Container registerPhoneNumbers(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    TextFieldInput(
                        controller: phoneNumberTextEditingController,
                        hintText: "Your Phone Number",
                        textInputType: TextInputType.text),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: emergencyPhoneNumber1TextEditingController,
                        hintText: "Emergency Contact 1 (required)",
                        textInputType: TextInputType.text),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: emergencyPhoneNumber2TextEditingController,
                        hintText: "Emergency Contact 2 (optional)",
                        textInputType: TextInputType.text),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextFieldInput(
                        controller: emergencyPhoneNumber3TextEditingController,
                        hintText: "Emergency Contact 3 (optional)",
                        textInputType: TextInputType.text),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _step = 1;
                                    });
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Previous"),
                                        ],
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () =>
                                      // Register user
                                      register(),
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Submit"),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
