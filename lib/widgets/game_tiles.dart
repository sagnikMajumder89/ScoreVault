import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badam_saath/widgets/game_tile.dart';

class GameTiles extends StatefulWidget {
  const GameTiles({super.key});
  @override
  State<GameTiles> createState() => _GameTilesState();
}

class _GameTilesState extends State<GameTiles> {
  var loadingGames = true;
  final _cloud = FirebaseFirestore.instance;
  String username = '';

  @override
  void initState() {
    super.initState();
    retrieveUsername();
  }

  void retrieveUsername() async {
    final doC = await _cloud
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    username = doC.data()!['username'];
    setState(() {
      loadingGames = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      child: StreamBuilder(
        stream: _cloud.collection('games').orderBy('createdat').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No games found'),
            );
          }
          if (snapshots.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          final loadedData = snapshots.data!.docs;
          final loadedGames = [];
          for (var i = 0; i < loadedData.length; i++) {
            final l = loadedData[i].data()['listofusers'] as List;
            print(username);
            if (l.contains(username)) {
              loadedGames.add(loadedData[i].data());
            }
          }
          if (loadedGames.isEmpty) {
            return const Center(
              child: Text('No games found'),
            );
          }
          if (loadingGames) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: loadedGames.length,
              itemBuilder: (ctx, index) {
                return GameTile(gameData: loadedGames[index]);
              });
        },
      ),
    );
  }
}
