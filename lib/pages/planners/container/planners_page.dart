import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:vote_planner/providers/providers.dart';

class PlannersPage extends StatefulWidget {
  PlannersPage({Key? key}) : super(key: key);

  @override
  _PlannersPageState createState() => _PlannersPageState();
}

class _PlannersPageState extends State<PlannersPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<UserProvider>(context).user!;

    return FutureBuilder<List<Planner>>(
      future: PlannerController.getPlannersByUserId(userId: currentUser.id!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<PlannersProvider>(
            create: (_) => PlannersProvider(snapshot.data!),
            builder: (context, child) {
              final PlannersProvider plannersProvider =
                  Provider.of<PlannersProvider>(context);

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Planners',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                body: PlannersPageView(
                  planners: plannersProvider.planners,
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
                                  final Planner newPlanner =
                                      await PlannerController.addPlanner(
                                    plannerTitle: textEditingController.text,
                                    user: currentUser,
                                  );

                                  plannersProvider.addPlanner(
                                      newPlanner: newPlanner);
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
              'Planners',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
