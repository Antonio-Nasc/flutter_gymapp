class ExerciseModel {
  String id;
  String name;
  String training;
  String howToDoIt;
  String? imageUrl;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.training,
    required this.howToDoIt,
  });

  ExerciseModel.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"],
      training = map["training"],
      howToDoIt = map["howToDoIt"],
      imageUrl = map["imageUrl"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "training": training,
      "howToDoIt": howToDoIt,
      "imageUrl": imageUrl,
    };
  }
}
