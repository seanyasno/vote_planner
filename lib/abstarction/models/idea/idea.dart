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
    this.plannerId = json['planner_id'];
    this.userId = json['user_id'];
    this.description = json['description'];
  }

  String toString() {
    return 'Id: $id, Planner Id: $plannerId, User Id: $userId, Description: $description';
  }
}
