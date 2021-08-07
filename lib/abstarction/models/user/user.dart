class User {
  String? id;
  String? name;

  User({required this.id, required this.name});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }

  String toString() {
    return 'id: $id, name: $name';
  }
}
