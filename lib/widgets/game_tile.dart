import 'package:badam_saath/screen/game_tile_screen.dart';
import 'package:flutter/material.dart';

class GameTile extends StatefulWidget {
  const GameTile({super.key, required this.gameData});
  final Map<String, dynamic> gameData;
  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    final gametitle = widget.gameData['gametitle'];
    return Card(
      elevation: 2,
      color: const Color.fromARGB(219, 226, 197, 253),
      child: ListTile(
        title: Text(
          gametitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: const Text('Game played by the Boyz'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => GameTileScreen(
                gameData: widget.gameData,
              ),
            ),
          );
        },
      ),
    );
  }
}
