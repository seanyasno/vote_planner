class Idea {
  String? id;
  String? plannerId;
  String? userId;
  String? description;

  Idea(
      {required this.id,
      required this.plannerId,
      required this.userId,
      required this.description});

  Idea.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.plannerId = json['plannerId'];
    this.userId = json['userId'];
    this.description = json['description'];
  }
}
