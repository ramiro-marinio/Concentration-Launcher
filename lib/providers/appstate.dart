import 'package:concentrationscreen/classes/addictive_app.dart';
import 'package:concentrationscreen/classes/app_use.dart';
import 'package:concentrationscreen/classes/daily_goal.dart';
import 'package:concentrationscreen/classes/note.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:local_auth/local_auth.dart';

class AppState extends ChangeNotifier {
  Database? database;
  List<Note>? notes;
  List<AppUse>? appUses;
  List<Application>? addictiveApps;
  List<DailyGoal>? goals;
  List<DailyGoal>? get goalsOfTheDay {
    List<DailyGoal> result = [];
    for (DailyGoal goal in goals!) {
      final now = DateTime.now();
      if (goal.createdAt >=
              DateTime(now.year, now.month, now.day).millisecondsSinceEpoch &&
          goal.createdAt <=
              DateTime(
                now.year,
                now.month,
                now.day,
                23,
                59,
                59,
              ).millisecondsSinceEpoch) {
        result += [goal];
      }
    }
    return result;
  }

  List<Application>? normalApps;
  bool? canAuthenticateWithBiometrics;
  bool? canAuthenticate;
  Future<void> updateNotes() async {
    notes =
        (await database!.query('note')).map((e) => Note.fromJson(e)).toList();
    notes!.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    notifyListeners();
  }

  Future<void> updateAppUses() async {
    final now = DateTime.now();
    final oneMonthMark =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch -
            1000 * 86400 * 30;
    appUses =
        (await database!.query('appUse', where: 'openedAt >= $oneMonthMark'))
            .map((e) => AppUse.fromJson(e))
            .toList();
    appUses!.sort(
      (a, b) => b.openedAt.compareTo(a.openedAt),
    );
    notifyListeners();
  }

  Future<void> updateApps({required bool init}) async {
    final markedApps = (await database!.query('addictiveApp'))
        .map((e) => AddictiveApp.fromJson(e).packageName)
        .toList();
    final getApps = init
        ? await DeviceApps.getInstalledApplications(
            onlyAppsWithLaunchIntent: true,
            includeAppIcons: true,
            includeSystemApps: true,
          )
        : normalApps! + addictiveApps!;
    normalApps = [];
    addictiveApps = [];
    for (Application element in getApps) {
      if (markedApps.contains(element.packageName)) {
        addictiveApps = addictiveApps! + [element];
      } else {
        normalApps = normalApps! + [element];
      }
    }
    addictiveApps!.sort(
      (a, b) => a.appName.compareTo(b.appName),
    );
    normalApps!.sort(
      (a, b) => a.appName.compareTo(b.appName),
    );
    notifyListeners();
  }

  Future<void> updateGoals() async {
    goals = (await database!.query('dailyGoal'))
        .map((e) => DailyGoal.fromJson(e))
        .toList();

    notifyListeners();
  }

  Future<void> markAsAddictive(String packageName) async {
    database!.insert(
      'addictiveApp',
      AddictiveApp(packageName: packageName).toJson(),
    );
    updateApps(init: false);
  }

  Future<void> unmarkAsAddictive(String packageName) async {
    database!.delete('addictiveApp', where: 'packageName = "$packageName"');
    updateApps(init: false);
  }

  Future<void> openApp(AppUse appUse) async {
    await database!.insert('appUse', appUse.toJson());
    await updateAppUses();
  }

  Future<void> deleteAppUse(AppUse appUse) async {
    await database!.delete('appUse', where: 'id=${appUse.id}');
    await updateAppUses();
  }

  Future<void> editEntry(Note note) async {
    if (note.id == null) {
      await database!.insert(
        'note',
        note.toJson(),
      );
    } else {
      await database!.update(
        'note',
        note.toJson(),
        where: 'id=${note.id}',
      );
    }
    updateNotes();
  }

  Future<void> deleteEntry(Note note) async {
    await database!.delete('note', where: 'id=${note.id}');
    updateNotes();
  }

  Future<void> editGoal(DailyGoal goal) async {
    if (goal.id == null) {
      await database!.insert('dailyGoal', goal.toJson());
    } else {
      await database!
          .update('dailyGoal', goal.toJson(), where: 'id=${goal.id}');
    }
    updateGoals();
  }

  Future<void> deleteGoal(DailyGoal goal) async {
    await database!.delete('dailyGoal', where: 'id=${goal.id}');
    updateGoals();
  }

  Future<void> init() async {
    final LocalAuthentication auth = LocalAuthentication();
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    canAuthenticate = canAuthenticateWithBiometrics ??
        false || await auth.isDeviceSupported();

    final dbPath = await getDatabasesPath();
    database = await openDatabase(
      '${dbPath}concentrationscreen.db',
      version: 1,
      onCreate: (db, version) async {
        final sql = await rootBundle.loadString('assets/createdb.sql');
        final List<String> statements = sql.split(';');
        for (String statement in statements) {
          if (statement.trim().isNotEmpty) {
            await db.execute(statement);
          }
        }
      },
    );
    await updateAppUses();
    await updateGoals();
    await updateNotes();
    await updateApps(init: true);
  }

  AppState() {
    init();
  }
}
