import 'package:provider/provider.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/planner/widgets/idea_item/idea_item.dart';
import 'package:vote_planner/abstarction/models/idea/idea.dart';
import 'package:flutter/material.dart';
import 'package:vote_planner/providers/ideas/ideas_provider.dart';

class PlannerPageView extends StatelessWidget {
  final List<Idea> ideas;
  final Planner planner;

  const PlannerPageView({
    Key? key,
    required this.planner,
    required this.ideas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IdeasProvider ideasProvider = Provider.of<IdeasProvider>(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: RefreshIndicator(
        child: ListView.separated(
          itemCount: ideas.length,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) => IdeaItem(idea: ideas[index]),
        ),
        onRefresh: () async {
          final List<Idea> refreshedIdeas =
              await PlannerController.getIdeasByPlannerId(planner.id);
          ideasProvider.resetIdeas(newIdeas: refreshedIdeas);
        },
      ),
    );
  }
}
