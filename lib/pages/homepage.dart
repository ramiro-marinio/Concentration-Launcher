import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/apps/apps.dart';
import 'package:concentrationscreen/widgets/buttons/buttons.dart';
import 'package:concentrationscreen/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    return Scaffold(
      body: appState.normalApps != null
          ? const Padding(
              padding: EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Column(
                children: [
                  TimeDisplay(),
                  Buttons(),
                  AppsList(
                    hiddenApps: false,
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
