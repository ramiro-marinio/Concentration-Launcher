import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationscreen/classes/app_stat.dart';
import 'package:concentrationscreen/classes/app_use.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/apps/app_use_display.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppUseScaffold extends StatelessWidget {
  const AppUseScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('App Use'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.history),
                  text: 'History',
                ),
                Tab(
                  icon: Icon(Icons.query_stats),
                  text: 'Statistics',
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AppUseHistory(),
              AppUseStatistics(),
            ],
          )),
    );
  }
}

class AppUseHistory extends StatelessWidget {
  const AppUseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    return appState.appUses != null
        ? SingleChildScrollView(
            child: Column(
              children: appState.appUses!
                  .map((e) => AppUseDisplay(appUse: e))
                  .toList(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }
}

class AppUseStatistics extends StatelessWidget {
  const AppUseStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    List<AppStat> stats = [];
    for (AppUse appUse in appState.appUses!) {
      if (stats
              .where((element) =>
                  element.application.packageName == appUse.packageName)
              .firstOrNull ==
          null) {
        final apps = appState.normalApps! + appState.addictiveApps!;
        final Application application = apps
            .firstWhere((element) => element.packageName == appUse.packageName);
        final bool addictive = appState.addictiveApps!.contains(application);
        stats += [
          AppStat(
            application: application,
            opened: 1,
            addictive: addictive,
          )
        ];
      } else {
        stats
            .firstWhere((element) =>
                element.application.packageName == appUse.packageName)
            .opened++;
      }
    }
    stats.sort((a, b) => b.opened.compareTo(a.opened));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Most opened apps of the last 30 days',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            ...List.generate(
              stats.length,
              (index) => SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 14,
                            backgroundImage:
                                stats[index].application.runtimeType ==
                                        ApplicationWithIcon
                                    ? MemoryImage((stats[index].application
                                            as ApplicationWithIcon)
                                        .icon)
                                    : null,
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            stats[index].application.appName,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        if (stats[index].addictive)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.warning),
                                Text('Addictive')
                              ],
                            ),
                          )
                      ],
                    ),
                    Text(
                      'Opened ${stats[index].opened} time${stats[index].opened != 1 ? 's' : ''}',
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
