import 'package:flutter/material.dart';
import 'package:vote_planner/abstarction/abstraction.dart';

class IdeaItem extends StatelessWidget {
  final Idea idea;

  const IdeaItem({Key? key, required this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).backgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          idea.description ?? 'could not load',
        ),
      ),
    );
  }
}
