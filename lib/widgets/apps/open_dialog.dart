import 'package:concentrationscreen/classes/app_use.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenDialog extends StatefulWidget {
  final Application application;
  const OpenDialog({super.key, required this.application});

  @override
  State<OpenDialog> createState() => _OpenDialogState();
}

class _OpenDialogState extends State<OpenDialog> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    AppState appState = context.watch<AppState>();
    return AlertDialog.adaptive(
      title: const Text('Why are you opening this app?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 200,
            onChanged: (v) {
              setState(() {
                text = v;
              });
            },
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
          onPressed: text.isNotEmpty
              ? () {
                  Navigator.pop(context);
                  appState.openApp(
                    AppUse(
                        packageName: widget.application.packageName,
                        openedAt: DateTime.now().millisecondsSinceEpoch,
                        reason: text),
                  );
                  DeviceApps.openApp(widget.application.packageName);
                }
              : null,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
