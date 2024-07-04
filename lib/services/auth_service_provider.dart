import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/user_model.dart';

class AuthServiceProvider extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a user object based on FirebaseUser
  UserModel _userFromFirebaseUser(User? user) {
    return UserModel(
      uid: user!.uid,
      email: user.email!,
      displayName: user.displayName ?? '',
      lastPracticeDate: DateTime.now(),
      streakCount: 0,
    );
  }

  // Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
        .map((User? user) => user != null ? _userFromFirebaseUser(user) : null);
  }

  // Sign up with email & password
  Future<UserCredential> signUpWithEmailAndPassword(
      String fullname, String email, String username, String password, String confirmPassword) async {
    try {
      // Check if the username already exists in the users collection
      QuerySnapshot query = await _firestore.collection('users')
          .where('username', isEqualTo: username).get();
      if (query.docs.isNotEmpty) {
        // Username already exists, throw an error or handle it accordingly
        throw Exception("Username already exists. Please choose a different one.");
      }

      // If the username is unique, proceed with user registration
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        throw Exception("User registration failed");
      }// Assuming fullname is the user's display name
      await user.updateProfile(displayName: fullname);

      // Create a UserModel instance using _userFromFirebaseUser
      UserModel newUser = _userFromFirebaseUser(user);

      // Store additional user information in the users collection
      await _firestore.collection('users').doc(user.uid).set(newUser.toFirestore()
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign in with email & password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      //await UserServiceProvider().updateActiveStatus(true);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
