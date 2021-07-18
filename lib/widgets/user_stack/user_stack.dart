import 'package:flutter/material.dart';
import 'package:vote_planner/abstarction/abstraction.dart';

class UserStack extends StatelessWidget {
  final List<User> users;

  const UserStack({Key? key, required this.users})
      : assert(users.length >= 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 13,
              child: Text(
                users[0].name![0].toUpperCase(),
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 13,
              child: Text(
                users[0].name![1].toUpperCase(),
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 13,
              child: Text(
                users[0].name![2].toUpperCase(),
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
