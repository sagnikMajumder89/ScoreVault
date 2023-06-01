import 'package:badam_saath/widgets/modal_add_players.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';

final _cloud = FirebaseFirestore.instance;
final _userId = FirebaseAuth.instance.currentUser!.uid;

class Modal extends StatefulWidget {
  const Modal({super.key});

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  final enteredTitle = TextEditingController();
  var _isUploading = false;
  int _noOfPlayers = 5;
  List<String> users = [];
  List<String> addedusers = [];
  void addUsersToaddedUsers(String userN) {
    addedusers.add(userN);
  }

  void _addGame() async {
    setState(() {
      _isUploading = true;
    });
    var snapshots = await _cloud.collection('users').get();
    for (var doc in snapshots.docs) {
      if (doc.data()['userid'] != _userId) {
        users.add(doc.data()['username']);
      } else {
        addedusers.add(doc.data()['username']);
      }
    }
    if (context.mounted) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Continue adding players'),
              content: Content(
                users: users,
                addPlayer: addUsersToaddedUsers,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            );
          });
    }
    await _cloud.collection('games').add({
      'gametitle': enteredTitle.text,
      'noofplayers': _noOfPlayers,
      'listofusers': addedusers,
      'createdat': Timestamp.now()
    });
    setState(() {
      _isUploading = false;
    });
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autofocus: true,
                decoration:
                    const InputDecoration(labelText: 'Enter Game Title'),
                controller: enteredTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: NumberPicker(
                value: _noOfPlayers,
                axis: Axis.horizontal,
                haptics: true,
                minValue: 2,
                maxValue: 10,
                onChanged: (value) => setState(() => _noOfPlayers = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                  color: Color.fromARGB(37, 212, 164, 240),
                ),
              ),
            ),
            Text('Number of players: $_noOfPlayers'),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!_isUploading)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: _addGame,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                  child: _isUploading
                      ? const CircularProgressIndicator()
                      : const Text('Add Players'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
