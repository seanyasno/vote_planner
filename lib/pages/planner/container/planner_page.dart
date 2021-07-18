import 'package:vote_planner/controllers/planner/planner_controller.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlannerPage extends StatelessWidget {
  final Planner planner;

  PlannerPage({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          planner.title,
          style: TextStyle(
            color: Color(0xFFc0e2de),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: PlannerController.getIdeasByPlannerId(planner.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PlannerPageView(
              ideas: snapshot.data as List<Idea>,
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ideaShimmerItem(),
                SizedBox(height: 10),
                ideaShimmerItem(height: 110),
                SizedBox(height: 10),
                ideaShimmerItem(),
                SizedBox(height: 10),
                ideaShimmerItem(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ideaShimmerItem({double height = 70}) {
    return Shimmer.fromColors(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300]!,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}
