import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/planner/widgets/idea_item_bottom/idea_item_bottom.dart';
import 'package:vote_planner/providers/providers.dart';

class IdeaItem extends StatelessWidget {
  final Idea idea;

  const IdeaItem({Key? key, required this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IdeaController.getUsersByIdeaId(idea.id ?? ''),
      builder: (context, snapshot) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).backgroundColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                snapshot.hasData
                    ? Text(
                        idea.description ?? 'could not load',
                        textAlign: TextAlign.start,
                      )
                    : Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 40,
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      ),
                Divider(),
                snapshot.hasData
                    ? ChangeNotifierProvider(
                        create: (_) =>
                            VotersProvider((snapshot.data ?? []) as List<User>),
                        builder: (context, child) {
                          final VotersProvider votersProvider =
                              Provider.of<VotersProvider>(context);
                          return IdeaItemBottom(
                            idea: idea,
                            votedUsers: votersProvider.voters,
                          );
                        },
                      )
                    : Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 18,
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
