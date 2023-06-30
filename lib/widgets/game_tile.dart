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
        leading: Icon(Icons.gamepad),
        tileColor: Color.fromARGB(245, 185, 128, 255),
        title: Text(
          gametitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
        subtitle: Row(
          children: [
            Text(
              'Subtitle',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            Expanded(child: Container()),
            Icon(Icons.format_list_numbered_sharp)
          ],
        ),
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
