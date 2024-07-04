import 'package:flutter/material.dart';

class StreakButton extends StatelessWidget {
  int numberOfStreak;

   StreakButton({super.key, required this.numberOfStreak});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      customBorder: CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.onInverseSurface
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.numberOfStreak.toString()),
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2)
              ),
              child: Icon(Icons.local_fire_department_rounded, ),
            )
          ],
        ),
      ),
    );
  }
}
