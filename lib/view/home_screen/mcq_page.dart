import 'package:flutter/material.dart';

class McqPage extends StatefulWidget {
  const McqPage({Key? key}) : super(key: key);

  @override
  State<McqPage> createState() => _McqPageState();
}

class _McqPageState extends State<McqPage> {
  int _currentQuestionIndex = 1; // Track the current question index
  List<String> _options = [
    'behind retina',
    'on retina',
    'front of retina',
    'anywhere depending on focus'
  ]; // Example options for the question

  String _selectedOption = ''; // Track the selected option
  bool _isAnswered = false; // Track if the question is answered

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEET Biology'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text('Question: $_currentQuestionIndex/24', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).colorScheme.surface,
                ),
                padding: EdgeInsets.all(12),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Where will the image of a distant object be formed when a person using a concave lens to correct vision, is not using glasses?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      Column(
                        children: _options
                            .asMap() // Use asMap() to access both index and value
                            .entries
                            .map(
                              (entry) => _buildOption(context, entry.key, entry.value),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, String optionText) {
    final optionAlphabet = String.fromCharCode('A'.codeUnitAt(0) + index); // Generate A, B, C, D, ...
    return InkWell(
      onTap: () {
        if (!_isAnswered) {
          setState(() {
            _selectedOption = optionText;
            _isAnswered = true; // Mark question as answered
          });
          // Handle option selection logic here
          print('Selected option: $_selectedOption');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '$optionAlphabet. $optionText', // Display alphabet (A, B, C, D) before option text
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            if (_isAnswered && _selectedOption == optionText)
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
