class PlannerUsers {
  String? plannerId;
  String? userId;

  PlannerUsers({required this.plannerId, required this.userId});

  PlannerUsers.fromJson(Map<String, dynamic> json) {
    this.plannerId = json['plannerId'];
    this.userId = json['userId'];
  }
}
