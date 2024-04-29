import 'dart:convert';

DailyGoal dailyGoalFromJson(String str) => DailyGoal.fromJson(json.decode(str));

String dailyGoalToJson(DailyGoal data) => json.encode(data.toJson());

class DailyGoal {
  int? id;
  int createdAt;
  String title;
  int? rating;

  DailyGoal({
    this.id,
    required this.createdAt,
    required this.title,
    this.rating,
  });

  factory DailyGoal.fromJson(Map<String, dynamic> json) => DailyGoal(
        id: json["id"],
        createdAt: json["createdAt"],
        title: json["title"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "createdAt": createdAt,
        "title": title,
        "rating": rating,
      };
}
