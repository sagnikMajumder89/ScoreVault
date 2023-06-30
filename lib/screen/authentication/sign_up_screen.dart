import 'package:badam_saath/screen/authentication/login_screen.dart';
import 'package:badam_saath/widgets/image_input.dart';
import 'package:badam_saath/widgets/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var enteredEmail = '';
  var enteredPassword = '';
  var enteredUsername = '';
  File? _selectedImage;
  var isAuthentication = false;
  final _formKey = GlobalKey<FormState>();
  void onSelectImage(File? image) {
    if (image == null) return;
    _selectedImage = image;
  }

  void submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedImage == null) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Please also add your Image',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Okay'),
                ),
              ],
            );
          });
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isAuthentication = true;
    });
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: enteredEmail, password: enteredPassword);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('userimage')
          .child('${userCredentials.user!.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'username': enteredUsername,
        'email': enteredEmail,
        'userid': FirebaseAuth.instance.currentUser!.uid,
        'userimage': imageUrl
      });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication error")));
    }
    setState(() {
      isAuthentication = false;
    });
    if (context.mounted) Navigator.of(context).pop();
  }

  void loginClick() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: isAuthentication
          ? const SplashScreen()
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome onboard!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Let\'s finish up with this sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 17),
                    ),
                    ImageInput(
                      imageSelected: onSelectImage,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 12, left: 12),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Username should be atleast 6 characters long';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter Username',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onSaved: (value) => enteredUsername = value!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 12, left: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Should be atleast 6 characters long';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter valid email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter Email-ID',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onSaved: ((newValue) => enteredEmail = newValue!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 12, left: 12),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 6) {
                                  return 'Passwords should consist of atleast 6 characters';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter Password',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onSaved: ((newValue) =>
                                  enteredPassword = newValue!),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              onPressed: submitData,
                              style: ElevatedButton.styleFrom(
                                shape: const BeveledRectangleBorder(),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: loginClick,
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
    ;
  }
}
