class Planner {
  late String id;
  late String title;
  late DateTime creation;

  Planner({required this.id, required this.title, required this.creation});

  Planner.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.creation = DateTime.parse(json['creation']);
  }

  String toString() {
    return '{id: $id, title: $title, creation: $creation}';
  }
}
