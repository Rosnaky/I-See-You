import 'package:ISeeYou/firebase_options.dart';
import 'package:ISeeYou/src/providers/medication_view_provider.dart';
import 'package:ISeeYou/src/providers/user_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()..refreshUser()),
    ChangeNotifierProvider(create: (_) => MedicationViewProvider())
  ], child: const ISeeYou()));
}
