class FeelingModel {
  String id;
  String feeling;
  String date;

  FeelingModel({required this.id, required this.feeling, required this.date});

  FeelingModel.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      feeling = map["feeling"],
      date = map["date"];

  Map<String, dynamic> toMap() {
    return {"id": id, "feeling": feeling, "date": date};
  }
}
