class Planner {
  String? id;
  String? title;
  DateTime? creation;

  Planner({required this.id, required this.title, required this.creation});

  Planner.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.creation = json['creation'];
  }
}
