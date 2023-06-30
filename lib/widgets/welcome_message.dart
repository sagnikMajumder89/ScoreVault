import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WelcomeMessage extends StatefulWidget {
  const WelcomeMessage({super.key});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  final _cloud = FirebaseFirestore.instance;
  var username = 'User';
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? imageLink;
  Future<void> _fetchUsername() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await _cloud.collection('users').get();
    for (var val in snapshot.docs) {
      if (val.data()['userid'] == userId) {
        setState(() {
          username = val.data()['username'] as String;
        });
        break;
      }
    }
  }

  void _getImage() async {
    final storageRef =
        FirebaseStorage.instance.ref().child('userimage').child('$userId.jpg');
    imageLink = await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    _fetchUsername();
    _getImage();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/gamescreenback.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height * 0.27,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: imageLink != null
                ? NetworkImage(imageLink!)
                : const AssetImage('assets/images/usericon.png')
                    as ImageProvider,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Welcome $username',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
