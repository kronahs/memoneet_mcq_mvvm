class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final DateTime lastPracticeDate;
  final int streakCount;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.lastPracticeDate,
    required this.streakCount,
  });

  // Convert a Firestore document to a UserModel
  factory UserModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      lastPracticeDate: data['lastPracticeDate']?.toDate() ?? DateTime.now(),
      streakCount: data['streakCount'] ?? 0,
    );
  }

  // Convert UserModel to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'lastPracticeDate': lastPracticeDate,
      'streakCount': streakCount
    };
  }
}
