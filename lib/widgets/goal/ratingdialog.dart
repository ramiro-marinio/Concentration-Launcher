import 'package:concentrationscreen/classes/daily_goal.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingDialog extends StatefulWidget {
  final DailyGoal dailyGoal;
  const RatingDialog({super.key, required this.dailyGoal});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int satisfaction = 0;
  @override
  Widget build(BuildContext context) {
    final AppState appState = context.read<AppState>();
    return AlertDialog.adaptive(
      title: const Text(
          'How satisfied are you with this goal on a scale from 0% to 100%?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: satisfaction.toDouble(),
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      satisfaction = value.round();
                    });
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: Text('$satisfaction%'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            appState.editGoal(widget.dailyGoal..rating = satisfaction);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        )
      ],
    );
  }
}
