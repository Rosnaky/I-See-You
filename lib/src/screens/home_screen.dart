import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/providers/user_provider.dart';
import 'package:ISeeYou/src/screens/medication_screen.dart';
import 'package:ISeeYou/src/screens/notify_screen.dart';
import 'package:ISeeYou/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [const NotifyScreen(), const MedicationScreen()];
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('ISeeYou: ${userProvider.user?.firstName ?? 'User'}'),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Auth().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                })
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) =>
              setState(() => selectedIndex = value),
        ),
        body: screens[selectedIndex]);
  }
}
