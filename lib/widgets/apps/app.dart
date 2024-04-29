import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/apps/open_dialog.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final Application application;
  const App({super.key, required this.application});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    AppState appState = context.watch<AppState>();
    bool addictive = appState.addictiveApps!.contains(widget.application);
    return GestureDetector(
      onLongPressStart: (details) {
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                details.globalPosition.dx,
                details.globalPosition.dy),
            items: [
              PopupMenuItem(
                child: Text(
                    !addictive ? 'Mark as Addictive' : 'Unmark as addictive'),
                onTap: () {
                  !addictive
                      ? appState.markAsAddictive(widget.application.packageName)
                      : appState
                          .unmarkAsAddictive(widget.application.packageName);
                },
              ),
              PopupMenuItem(
                child: const Text('Open Settings'),
                onTap: () {
                  widget.application.openSettingsScreen();
                },
              ),
              PopupMenuItem(
                child: const Text('Uninstall'),
                onTap: () async {
                  final packageName = widget.application.packageName;
                  final success = await widget.application.uninstallApp();
                  if (success) {
                    final normalApps = appState.normalApps!;
                    final addictiveApps = appState.addictiveApps!;
                    appState.normalApps = [];
                    appState.addictiveApps = [];
                    for (var element in normalApps) {
                      if (element.packageName != packageName) {
                        appState.normalApps = appState.normalApps! + [element];
                      }
                    }
                    for (var element in addictiveApps) {
                      if (element.packageName != packageName) {
                        appState.addictiveApps =
                            appState.addictiveApps! + [element];
                      }
                    }
                    appState.updateApps(init: false);
                  }
                },
              )
            ]);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 20,
          backgroundImage: widget.application.runtimeType == ApplicationWithIcon
              ? MemoryImage((widget.application as ApplicationWithIcon).icon)
              : null,
        ),
        onTap: () => {
          showDialog(
              context: context,
              builder: (context) {
                return OpenDialog(application: widget.application);
              })
        },
        title: Text(widget.application.appName),
      ),
    );
  }
}
