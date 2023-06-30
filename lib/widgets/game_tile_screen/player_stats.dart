import 'package:flutter/material.dart';

class PlayerStats extends StatelessWidget {
  const PlayerStats({super.key, required this.gameData});
  final Map<String, dynamic> gameData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  'Stats:',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                for (var playerScores = 0;
                    playerScores < gameData['listofusers'].length;
                    playerScores++)
                  Column(
                    children: [
                      Card(
                        child: Row(children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${playerScores + 1}. ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 17),
                          ),
                          Text(
                            gameData['listofusers'][playerScores]['username'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 17),
                          ),
                          Expanded(child: Container()),
                          Text((gameData['listofusers'][playerScores]['scores'])
                              .toString()),
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
