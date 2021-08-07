import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/providers/providers.dart';
import 'package:vote_planner/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class IdeaItemBottom extends StatefulWidget {
  final Idea idea;
  final List<User> votedUsers;

  const IdeaItemBottom({Key? key, required this.idea, required this.votedUsers})
      : super(key: key);

  @override
  _IdeaItemBottomState createState() => _IdeaItemBottomState();
}

class _IdeaItemBottomState extends State<IdeaItemBottom> {
  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<UserProvider>(context).user!;
    final VotersProvider votersProvider = Provider.of<VotersProvider>(context);

    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.arrow_upward,
            color: widget.votedUsers.any((user) => user.id == currentUser.id)
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          onTap: () async {
            if (widget.votedUsers.any((user) => user.id == currentUser.id)) {
              await IdeaController.removeVote(
                  ideaId: widget.idea.id!, userId: currentUser.id!);
              votersProvider.removeVoter(userId: currentUser.id!);
            } else {
              await IdeaController.upvoteIdea(widget.idea.id!, currentUser.id!);
              final votedUsers =
                  await IdeaController.getUsersByIdeaId(widget.idea.id!);
              votersProvider.resetVoters(newVoters: votedUsers);
            }
          },
          borderRadius: BorderRadius.circular(10),
        ),
        widget.votedUsers.length > 3
            ? Container(
                width: 75,
                height: 30,
                child: UserStack(
                  users: widget.votedUsers,
                ),
              )
            : (widget.votedUsers.length == 0
                ? Container()
                : Container(
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13,
                        child: Text(
                          widget.votedUsers[0].name![0],
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ),
                  )),
        widget.votedUsers.length == 0
            ? Container()
            : Text(getVotedAmountText()),
      ],
    );
  }

  String getVotedAmountText() {
    if (widget.votedUsers.length > 3) {
      return '+${widget.votedUsers.length - 3} voted';
    } else if (widget.votedUsers.length > 1) {
      return '+${widget.votedUsers.length - 1} voted';
    } else {
      return '';
    }
  }
}
