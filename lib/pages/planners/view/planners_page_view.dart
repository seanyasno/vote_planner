import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:vote_planner/providers/providers.dart';

class PlannersPageView extends StatelessWidget {
  final List<Planner> planners;

  const PlannersPageView({Key? key, required this.planners}) : super(key: key);

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
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: planners.length,
          itemBuilder: (context, index) {
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
                      planners[index].title,
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
                            builder: (context) =>
                                PlannerPage(planner: planners[index]),
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
