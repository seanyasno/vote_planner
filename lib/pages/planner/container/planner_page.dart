import 'package:flutter/material.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/planner/planner_controller.dart';
import 'package:vote_planner/pages/pages.dart';

class PlannerPage extends StatelessWidget {
  const PlannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '[Planner title here]',
          style: TextStyle(
            color: Color(0xFFc0e2de),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: PlannerController.getIdeasByPlannerId(
            'f6d62926-bd79-497e-81ea-057f0c2e9ef9'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PlannerPageView(ideas: snapshot.data as List<Idea>);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
