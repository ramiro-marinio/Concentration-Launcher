import 'package:concentrationscreen/pages/daily_goals/goal_add_sheet.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/goal/goaldisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyGoals extends StatefulWidget {
  const DailyGoals({super.key});

  @override
  State<DailyGoals> createState() => _DailyGoalsState();
}

class _DailyGoalsState extends State<DailyGoals> {
  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Goals'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            appState.goalsOfTheDay!.length,
            (index) =>
                DailyGoalDisplay(dailyGoal: appState.goalsOfTheDay![index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddGoal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
