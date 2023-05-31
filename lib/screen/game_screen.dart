import 'package:badam_saath/widgets/game_tiles.dart';
import 'package:badam_saath/widgets/modal_sheet.dart';
import 'package:badam_saath/widgets/welcome_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void _showModalSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return const Modal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(173, 151, 116, 240),
          title: Text(
            'Dashboard',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          actions: [
            IconButton(onPressed: _showModalSheet, icon: const Icon(Icons.add)),
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const WelcomeMessage(),
              GameTiles(
                key: UniqueKey(),
              ),
            ],
          ),
        ));
  }
}
