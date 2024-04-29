import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationscreen/classes/daily_goal.dart';
import 'package:concentrationscreen/pages/addictiveapps.dart';
import 'package:concentrationscreen/pages/app_use_history/app_use_history.dart';
import 'package:concentrationscreen/pages/daily_goals/daily_goals.dart';
import 'package:concentrationscreen/pages/notebook/private_notebook.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/buttons/squarebutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    int doneGoals = 0;
    if (appState.goalsOfTheDay?.isNotEmpty ?? false) {
      doneGoals = 0;
      for (DailyGoal goal in appState.goalsOfTheDay!) {
        if (goal.rating != null) {
          doneGoals++;
        }
      }
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        SquareButton(
          title: 'Daily Goals',
          icon: appState.goalsOfTheDay?.isEmpty ?? true
              ? const Icon(Icons.checklist)
              : AutoSizeText(
                  '$doneGoals/${appState.goalsOfTheDay?.length}',
                  style: const TextStyle(fontSize: 18),
                  minFontSize: 1,
                ),
          push: const DailyGoals(),
        ),
        SquareButton(
          title: 'Private Notebook',
          icon: const Icon(Icons.menu_book_rounded),
          enabled: appState.canAuthenticate ?? false,
          requiresAuth: true,
          push: const PrivateNotebook(),
        ),
        const SquareButton(
          title: 'App Use History',
          icon: Icon(Icons.history),
          push: AppUseScaffold(),
        ),
        const SquareButton(
          title: 'Addictive Apps',
          icon: Icon(Icons.warning),
          push: AddictiveApps(),
        ),
        // SquareButton(
        //   title: 'Insights',
        //   icon: Icon(Icons.lightbulb),
        //   push: HomePage(),
        // ),
      ],
    );
  }
}
