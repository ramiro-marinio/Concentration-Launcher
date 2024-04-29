import 'package:concentrationscreen/classes/daily_goal.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGoal extends StatefulWidget {
  final DailyGoal? editGoal;
  const AddGoal({super.key, this.editGoal});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  TextEditingController title = TextEditingController();
  @override
  void initState() {
    super.initState();
    title.text = widget.editGoal?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.editGoal != null ? 'Edit Goal' : 'New Goal',
              style: const TextStyle(fontSize: 24),
            ),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: widget.editGoal != null
                          ? widget.editGoal!.title
                          : 'Your Goal',
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                    maxLength: 500,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: title.text.isNotEmpty
                        ? () {
                            print(DateTime.now().millisecondsSinceEpoch);
                            appState.editGoal(
                              DailyGoal(
                                createdAt: widget.editGoal?.createdAt ??
                                    DateTime.now().millisecondsSinceEpoch,
                                title: title.text,
                                id: widget.editGoal?.id,
                                rating: null,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Save'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
