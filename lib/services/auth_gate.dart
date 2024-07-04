import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../view/auth_screen/logInPage.dart';
import '../widgets/bottom_nav.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for auth state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is authenticated, show main app screen
            return BottomNavigation();
          } else {
            // User is not authenticated, show login page
            return LogInPage();
          }
        }
      },
    );
  }
}
