import 'package:daily_mcq_mvvm/view/auth_screen/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service_provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void onLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    final authService = Provider.of<AuthServiceProvider>(context, listen: false);

    try{
      await authService.signInWithEmailAndPassword(email, password);
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top center outside the card
            // Centered card containing the login form
            Text('Daily MCQ', style: GoogleFonts.poppins(fontSize: 34),),
            Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        onLogin();
                      },
                      child: Text('Log In'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the login page when the text is tapped
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: Text(
                          'Create account, Signup'
                      ),
                    ),
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
