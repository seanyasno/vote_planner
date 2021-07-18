import 'package:vote_planner/pages/planner/widgets/idea_item/idea_item.dart';
import 'package:vote_planner/abstarction/models/idea/idea.dart';
import 'package:flutter/material.dart';

class PlannerPageView extends StatelessWidget {
  final List<Idea> ideas;

  const PlannerPageView({
    Key? key,
    required this.ideas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: ideas
              .map(
                (idea) => Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: IdeaItem(idea: idea),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
