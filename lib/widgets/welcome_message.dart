import 'package:badam_saath/widgets/image_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeMessage extends StatefulWidget {
  const WelcomeMessage({super.key});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

final _cloud = FirebaseFirestore.instance;

class _WelcomeMessageState extends State<WelcomeMessage> {
  var username = 'User';

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

  @override
  Widget build(BuildContext context) {
    _fetchUsername();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/gamescreenback.png',
          ),
          fit: BoxFit.cover,
        ),
        // borderRadius: BorderRadius.all(Radius.circular(12)),
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromARGB(255, 127, 130, 235),
        //     Color.fromARGB(255, 84, 169, 219),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height * 0.27,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 62,
            backgroundColor: Color.fromARGB(225, 151, 116, 240),
            child: ClipOval(
              child: SizedBox(
                width: 120,
                height: 120,
                child: ImageInput(),
              ),
            ),
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
