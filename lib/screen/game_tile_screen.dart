import 'package:badam_saath/widgets/game_tile_screen/player_stats.dart';
import 'package:badam_saath/widgets/game_tile_screen/score_updater.dart';
import 'package:flutter/material.dart';

class GameTileScreen extends StatelessWidget {
  const GameTileScreen({super.key, required this.gameData});
  final Map<String, dynamic> gameData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${gameData['gametitle']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PlayerStats(gameData: gameData),
              ScoreUpdater(),
            ],
          ),
        ),
      ),
    );
  }
}
