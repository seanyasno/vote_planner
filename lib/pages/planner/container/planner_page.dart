import 'package:flutter/services.dart';
import 'package:vote_planner/controllers/planner/planner_controller.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/providers/providers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlannerPage extends StatefulWidget {
  final Planner planner;

  PlannerPage({Key? key, required this.planner}) : super(key: key);

  @override
  _PlannerPageState createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<UserProvider>(context).user!;

    return FutureBuilder(
      future: PlannerController.getIdeasByPlannerId(widget.planner.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<IdeasProvider>(
            create: (_) => IdeasProvider(
                snapshot.hasData ? snapshot.data as List<Idea> : []),
            builder: (context, child) {
              final IdeasProvider ideasProvider =
                  Provider.of<IdeasProvider>(context);

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.planner.title,
                    style: TextStyle(
                      color: Color(0xFFc0e2de),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  actions: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Icon(Icons.content_copy),
                      ),
                      borderRadius: BorderRadius.circular(200),
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.planner.id));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "${widget.planner.title}'s id copied",
                            textAlign: TextAlign.center,
                          ),
                        ));
                      },
                    ),
                  ],
                ),
                body: PlannerPageView(
                  ideas: ideasProvider.ideas,
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController textEditingController =
                            TextEditingController();
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Have a new idea?',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                TextFormField(
                                  controller: textEditingController,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : 'Invalid Field';
                                  },
                                  minLines: 1,
                                  maxLines: 6,
                                  decoration: InputDecoration(
                                    hintText: 'Write your new idea here',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final Idea newIdea =
                                      await IdeaController.addIdea(
                                    idea: Idea(
                                      id: null,
                                      plannerId: widget.planner.id,
                                      userId: currentUser.id,
                                      description: textEditingController.text,
                                    ),
                                  );
                                  ideasProvider.addIdea(newIdea: newIdea);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.planner.title,
              style: TextStyle(
                color: Color(0xFFc0e2de),
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          body: Container(
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
          ),
        );
      },
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
