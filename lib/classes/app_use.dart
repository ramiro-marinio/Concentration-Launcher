import 'dart:convert';

AppUse appUseFromJson(String str) => AppUse.fromJson(json.decode(str));

String appUseToJson(AppUse data) => json.encode(data.toJson());

class AppUse {
  int? id;
  String packageName;
  int openedAt;
  String reason;

  AppUse({
    this.id,
    required this.packageName,
    required this.openedAt,
    required this.reason,
  });

  factory AppUse.fromJson(Map<String, dynamic> json) => AppUse(
        id: json["id"],
        packageName: json["packageName"],
        openedAt: json["openedAt"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "packageName": packageName,
        "openedAt": openedAt,
        "reason": reason,
      };
}
