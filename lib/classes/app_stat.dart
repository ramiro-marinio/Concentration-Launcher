import 'dart:convert';

import 'package:device_apps/device_apps.dart';

AppStat appStatFromJson(String str) => AppStat.fromJson(json.decode(str));

String appStatToJson(AppStat data) => json.encode(data.toJson());

class AppStat {
  Application application;
  int opened;
  bool addictive;

  AppStat(
      {required this.application,
      required this.opened,
      required this.addictive});

  factory AppStat.fromJson(Map<String, dynamic> json) => AppStat(
        application: json["application"],
        opened: json["opened"],
        addictive: json["addictive"],
      );

  Map<String, dynamic> toJson() =>
      {"application": application, "opened": opened, "addictive": addictive};
}
