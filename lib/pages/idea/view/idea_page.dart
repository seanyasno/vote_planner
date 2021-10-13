import 'package:flutter/material.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';

class IdeaPage extends StatelessWidget {
  final Idea idea;

  const IdeaPage({Key? key, required this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Idea Page',
          style: TextStyle(
            color: Color(0xFFc0e2de),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Theme.of(context).backgroundColor,
              child: FutureBuilder<User>(
                future: UserController.getUserById(userId: idea.userId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.name!),
                          Text(
                            idea.description!,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.fontSize,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
