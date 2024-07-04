import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StreakViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _streakCount = 0;

  int get streakCount => _streakCount;

  StreakViewModel() {
    _fetchStreakCount();
  }

  Future<void> _fetchStreakCount() async {
    try {
      // Fetch the user's streak count from Firestore
      DocumentSnapshot streakSnapshot = await _firestore.collection('userStreaks').doc('exampleUserId').get();
      _streakCount = streakSnapshot['streakCount'] ?? 0;
      notifyListeners();
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }

  Future<void> updateStreak() async {
    try {
      // Update the user's streak count in Firestore
      await _firestore.collection('userStreaks').doc('exampleUserId').update({
        'streakCount': _streakCount + 1,
      });
      _streakCount++;
      notifyListeners();
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }
}
