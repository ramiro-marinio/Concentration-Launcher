import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationscreen/classes/app_use.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppUseDisplay extends StatelessWidget {
  final AppUse appUse;
  const AppUseDisplay({super.key, required this.appUse});

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    Application? application;
    for (Application element
        in appState.normalApps! + appState.addictiveApps!) {
      if (element.packageName == appUse.packageName) {
        application = element;
        break;
      }
    }

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (application.runtimeType == ApplicationWithIcon)
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        backgroundImage:
                            application.runtimeType == ApplicationWithIcon
                                ? MemoryImage(
                                    (application as ApplicationWithIcon).icon)
                                : null,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 1,
                          application?.appName ??
                              'Not found. App Package Name = ${appUse.packageName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        appState.deleteAppUse(appUse);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                Text(
                  'Opened ${DateFormat('MMMM d y HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(appUse.openedAt))}',
                ),
                Expanded(child: AutoSizeText('Reason: ${appUse.reason}'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
