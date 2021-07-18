import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:vote_planner/providers/providers.dart';

class PlannersPage extends StatelessWidget {
  const PlannersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<UserProvider>(context).user!;

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
      body: FutureBuilder<List<Planner>>(
        future: PlannerController.getPlannersByUserId(userId: currentUser.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider<PlannersProvider>(
              create: (_) => PlannersProvider(snapshot.data!),
              builder: (context, child) {
                final PlannersProvider plannersProvider =
                    Provider.of<PlannersProvider>(context);

                return PlannersPageView(
                  planners: plannersProvider.planners,
                );
              },
            );
          }

          return Padding(
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
          );
        },
      ),
    );
  }
}
