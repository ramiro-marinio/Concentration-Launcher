import 'package:concentrationscreen/widgets/apps/apps.dart';
import 'package:flutter/material.dart';

class AddictiveApps extends StatefulWidget {
  const AddictiveApps({super.key});

  @override
  State<AddictiveApps> createState() => _AddictiveAppsState();
}

class _AddictiveAppsState extends State<AddictiveApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addictive Apps'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppsList(
              hiddenApps: true,
            ),
          ],
        ),
      ),
    );
  }
}
