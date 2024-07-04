import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class McqViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _currentQuestion;
  bool _hasAnsweredToday = false;

  String? get currentQuestion => _currentQuestion;
  bool get hasAnsweredToday => _hasAnsweredToday;

  McqViewModel() {
    _fetchDailyQuestion();
  }

  Future<void> _fetchDailyQuestion() async {
    try {
      // Fetch today's question from Firestore
      DocumentSnapshot questionSnapshot = await _firestore.collection('dailyQuestions').doc('today').get();
      _currentQuestion = questionSnapshot['question'];
      _checkIfAnsweredToday();
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }

  Future<void> _checkIfAnsweredToday() async {
    // Implement logic to check if the user has answered today's question
    // For example, check a collection where you store user's answers
    _hasAnsweredToday = true; // Example value
    notifyListeners();
  }

  Future<void> submitAnswer(String answer) async {
    try {
      if (!_hasAnsweredToday) {
        // Submit the answer to Firestore
        await _firestore.collection('userAnswers').add({
          'userId': 'exampleUserId', // Replace with actual user ID
          'question': _currentQuestion,
          'answer': answer,
          'date': DateTime.now(),
        });
        _hasAnsweredToday = true;
        notifyListeners();
      }
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }
}
