import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UniPlanApp());
}

class UniPlanApp extends StatelessWidget {
  const UniPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniPlan Student Planner',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6258F5),
        ),
      ),

      home: const SplashScreen(
        nextScreen: AuthCheckScreen(),
      ),
    );
  }
}

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Authentication error'),
            ),
          );
        }

        if (snapshot.hasData) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('UniPlan Dashboard'),
      backgroundColor: const Color(0xFF6258F5),
      foregroundColor: Colors.white,

      actions: [
        IconButton(
          tooltip: 'Logout',
          icon: const Icon(Icons.logout_rounded),

          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
        ),
      ],
    ),

    body: const Center(
      child: Text(
        'Welcome to UniPlan! 🎓',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6258F5),
        ),
      ),
    ),
  );
}

return const LoginScreen();
      },
    );
  }
}