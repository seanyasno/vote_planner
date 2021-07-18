import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:vote_planner/providers/providers.dart';

class PlannersPageView extends StatefulWidget {
  final List<Planner> planners;

  const PlannersPageView({Key? key, required this.planners}) : super(key: key);

  @override
  _PlannersPageViewState createState() => _PlannersPageViewState();
}

class _PlannersPageViewState extends State<PlannersPageView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final PlannersProvider plannersProvider =
        Provider.of<PlannersProvider>(context);
    final User currentUser = Provider.of<UserProvider>(context).user!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: RefreshIndicator(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widget.planners.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Center(
                      child: Text(
                        'Join to a plan',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                onTap: () async {
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
                                'Want to join to a plan?',
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
                                maxLines: 2,
                                decoration: InputDecoration(
                                  hintText: 'Write plan id here',
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
                                final Planner? newPlanner =
                                    await PlannerController.joinPlanner(
                                  plannerId: textEditingController.text,
                                  user: currentUser,
                                );

                                if (newPlanner == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Invalid id or you are already inside'),
                                  ));
                                } else {
                                  plannersProvider.addPlanner(
                                      newPlanner: newPlanner);
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Text('Add'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.planners[index - 1].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlannerPage(
                                planner: widget.planners[index - 1]),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          final List<Planner> refreshedPlanners =
              await PlannerController.getPlannersByUserId(
                  userId: currentUser.id!);
          plannersProvider.resetPlanners(newPlanners: refreshedPlanners);
        },
      ),
    );
  }
}
