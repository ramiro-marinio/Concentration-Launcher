import 'dart:convert';

AddictiveApp addictiveAppFromJson(String str) =>
    AddictiveApp.fromJson(json.decode(str));

String addictiveAppToJson(AddictiveApp data) => json.encode(data.toJson());

class AddictiveApp {
  String packageName;

  AddictiveApp({
    required this.packageName,
  });

  factory AddictiveApp.fromJson(Map<String, dynamic> json) => AddictiveApp(
        packageName: json["packageName"],
      );

  Map<String, dynamic> toJson() => {
        "packageName": packageName,
      };
}
