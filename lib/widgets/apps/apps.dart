import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/apps/app.dart';
import 'package:concentrationscreen/widgets/apps/searchbar.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppsList extends StatefulWidget {
  final bool hiddenApps;
  const AppsList({super.key, this.hiddenApps = false});

  @override
  State<AppsList> createState() => _AppsListState();
}

class _AppsListState extends State<AppsList> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    List<Application>? apps =
        widget.hiddenApps ? appState.addictiveApps : appState.normalApps;
    return Expanded(
      child: Column(
        children: [
          AppSearchBar(
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
          Expanded(
              child: ListView(
            children: List.generate(
              apps!.length,
              (index) => Visibility(
                visible: apps[index].appName.toLowerCase().contains(
                      search.toLowerCase(),
                    ),
                child: App(
                  application: apps[index],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
