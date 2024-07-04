import 'package:daily_mcq_mvvm/view/home_screen/mcq_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/streak_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasAnsweredToday = false; // Track if today's question has been answered

  void _onTapSubject(String subject) {
    if (_hasAnsweredToday) {
      // Show a message or navigate to a different screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You have already answered today's question.")));
    } else {
      // Handle subject tap
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => McqPage()),
      );

      // You can navigate to another screen or perform any other action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi Jamie, ', style: Theme.of(context).textTheme.bodyMedium,),
                      SizedBox(height: 6,),
                      Text('Welcome Back!', style: Theme.of(context).textTheme.titleMedium,),
                    ],
                  ),
                  StreakButton(numberOfStreak: 0,),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage('https://media.istockphoto.com/id/1456547836/photo/three-white-question-marks-a-blue-wall-background.webp?b=1&s=170667a&w=0&k=20&c=W1_A4mk1ByWN7XzNPutSUX-hDqI1EdNxQW_BN6AHN38='),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Daily Multiple\nChoice', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Subjects', style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 14,),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSubjectCard(context, 'NEET Biology', 'MCQs on Structure of Eye', Icons.science, 70, 30, !_hasAnsweredToday),
                  // Add more subjects here
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, String subject, String description, IconData icon, int progress, int questionsRemaining, bool isAvailable) {
    return InkWell(
      onTap: isAvailable ? () => _onTapSubject(subject) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isAvailable ? Theme.of(context).colorScheme.primary.withOpacity(0.4) : Colors.grey.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24,),
                SizedBox(width: 8,),
                Text(subject, style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
            SizedBox(height: 10,),
            Text(description, style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: 10,),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 5,),
            Text('$questionsRemaining questions remaining', style: Theme.of(context).textTheme.bodySmall,),
            if (!isAvailable)
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.lock, color: Colors.red, size: 20,),
              ),
          ],
        ),
      ),
    );
  }
}

