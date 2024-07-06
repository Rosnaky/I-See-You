import 'package:ISeeYou/firebase_options.dart';
import 'package:ISeeYou/src/providers/user_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'src/app.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  launchUrlString("tel://5194984082");

  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()..refreshUser())
  ], child: const ISeeYou()));
}
