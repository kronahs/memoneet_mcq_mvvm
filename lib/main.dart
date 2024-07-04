import 'package:daily_mcq_mvvm/services/auth_gate.dart';
import 'package:daily_mcq_mvvm/services/auth_service_provider.dart';
import 'package:daily_mcq_mvvm/view/auth_screen/authOptionsPage.dart';
import 'package:daily_mcq_mvvm/view/auth_screen/logInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options:  FirebaseOptions(
        apiKey: "AIzaSyCCeBDLxqrzYgAhErMhZmQufMbNAyZGefo",
        appId: "1:156814059452:web:fb7b00a8454e3e21f8adb9",
        messagingSenderId: "156814059452",
        projectId: "convo-chat-de3fa",
        storageBucket: "convo-chat-de3fa.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServiceProvider()),
        //ChangeNotifierProvider(create: (context) => UserServiceProvider()),
      ],
      child: MaterialApp(
        title: 'Daily MCQ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.light),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
            textTheme: TextTheme(
              titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
              titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
            )
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey, brightness: Brightness.dark),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
          textTheme: TextTheme(
            titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ),
        home: AuthGate()
      ),
    );
  }
}
