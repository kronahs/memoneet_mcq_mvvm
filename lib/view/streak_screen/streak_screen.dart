import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  late User? _user;
  int _streakCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _fetchStreakData();
  }

  Future<void> _fetchStreakData() async {
    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _streakCount = userDoc['streakCount'] ?? 0;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Streak'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Streak',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 20),
            _buildStreakCard(context),
            SizedBox(height: 20),
            _buildStreakProgressBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.local_fire_department, size: 40, color: Colors.orange),
            SizedBox(width: 16),
            Text(
              '$_streakCount Days',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakProgressBar(BuildContext context) {
    // Assuming max streak goal is 30 days for visual representation
    int maxStreakGoal = 30;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress towards 30-day streak',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: _streakCount / maxStreakGoal,
          backgroundColor: Colors.grey[300],
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
