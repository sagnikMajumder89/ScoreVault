import 'package:flutter/material.dart';

class ScoreUpdater extends StatelessWidget {
  const ScoreUpdater({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        icon: Icon(Icons.update),
        label: Text('Update Scores'));
  }
}
