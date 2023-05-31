import 'package:badam_saath/screen/authentication/login_screen.dart';
import 'package:badam_saath/screen/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  void loginClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  void signUpClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset(
            'assets/images/title.png',
            width: 350,
          ),
          Center(
            child: Image.asset(
              'assets/images/introgif.gif',
              fit: BoxFit.cover,
              width: 200,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 10,
                            left: 20,
                          ),
                          child: Text(
                            'Welcome!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: FittedBox(
                            child: Text(
                              'A place to store all your game scores with ease.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: loginClick,
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(),
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        child: Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: const BeveledRectangleBorder(),
                            backgroundColor:
                                Color.fromARGB(255, 205, 206, 244)),
                        onPressed: signUpClick,
                        child: Text(
                          'SIGNUP',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
