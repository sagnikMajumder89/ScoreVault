import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({Key? key, required this.users, required this.addPlayer})
      : super(key: key);
  final List users;
  final Function(String val) addPlayer;
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<String> addedUsers = [];

  @override
  Widget build(BuildContext context) {
    var users = widget.users;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.7,
      child: users.isEmpty
          ? const Center(child: Text('No players are remaining to add'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(users[index]),
                  onTap: () {
                    setState(() {
                      widget.addPlayer(users[index]);
                      users.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
