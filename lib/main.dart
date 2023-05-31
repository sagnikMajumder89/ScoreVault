import 'package:badam_saath/screen/game_screen.dart';
import 'package:badam_saath/widgets/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badam_saath/screen/authentication/auth_screen1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 116, 118, 239),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 205, 206, 244),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 205, 206, 244)),
    textTheme: GoogleFonts.poppinsTextTheme());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return GameScreen(
              key: UniqueKey(),
            );
          }
          return const AuthenticationScreen();
        },
      ),
    );
  }
}
