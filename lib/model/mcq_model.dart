// class MCQ {
//   String id;
//   String question;
//   List<String> options;
//   String correctAnswer;
//   String category;
//
//   MCQ({
//     required this.id,
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//     required this.category,
//   });
//
//   factory MCQ.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map;
//     return MCQ(
//       id: doc.id,
//       question: data['question'] ?? '',
//       options: List<String>.from(data['options'] ?? []),
//       correctAnswer: data['correctAnswer'] ?? '',
//       category: data['category'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'question': question,
//       'options': options,
//       'correctAnswer': correctAnswer,
//       'category': category,
//     };
//   }
// }
