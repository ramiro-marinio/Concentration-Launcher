import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationscreen/classes/daily_goal.dart';
import 'package:concentrationscreen/functions/whiten.dart';
import 'package:concentrationscreen/pages/daily_goals/goal_add_sheet.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/are_you_sure.dart';
import 'package:concentrationscreen/widgets/goal/ratingdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyGoalDisplay extends StatefulWidget {
  final DailyGoal dailyGoal;
  const DailyGoalDisplay({super.key, required this.dailyGoal});

  @override
  State<DailyGoalDisplay> createState() => _DailyGoalDisplayState();
}

class _DailyGoalDisplayState extends State<DailyGoalDisplay> {
  @override
  Widget build(BuildContext context) {
    final AppState appState = context.read<AppState>();
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: widget.dailyGoal.rating != null
            ? Theme.of(context).brightness == Brightness.light
                ? adjustWhiteness(
                    Color.fromARGB(
                        255,
                        ((1 - widget.dailyGoal.rating! / 100) * 255).round(),
                        (widget.dailyGoal.rating! / 100 * 220).round(),
                        0),
                    0.8,
                  )
                : adjustDarkness(
                    Color.fromARGB(
                        255,
                        ((1 - widget.dailyGoal.rating! / 100) * 255).round(),
                        (widget.dailyGoal.rating! / 100 * 220).round(),
                        0),
                    0.8,
                  )
            : null,
        child: Stack(
          children: [
            if (widget.dailyGoal.rating != null)
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  '${widget.dailyGoal.rating}%/100%',
                  style: TextStyle(
                    color: Color.fromARGB(
                      255,
                      ((1 - widget.dailyGoal.rating! / 100) * 255).round(),
                      (widget.dailyGoal.rating! / 100 * 220).round(),
                      0,
                    ),
                  ),
                ),
              )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      minFontSize: 4,
                      overflow: TextOverflow.ellipsis,
                      widget.dailyGoal.title,
                      style: TextStyle(
                        decoration: widget.dailyGoal.rating != null
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.dailyGoal.rating == null
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => RatingDialog(
                                dailyGoal: widget.dailyGoal,
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: widget.dailyGoal.rating == null
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => AddGoal(
                                editGoal: widget.dailyGoal,
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: widget.dailyGoal.rating == null
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => AreYouSure(
                                yes: () {
                                  appState.deleteGoal(widget.dailyGoal);
                                },
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
