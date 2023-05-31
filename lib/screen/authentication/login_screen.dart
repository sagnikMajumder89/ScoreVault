import 'package:badam_saath/screen/authentication/sign_up_screen.dart';
import 'package:badam_saath/widgets/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var enteredEmail = '';
  var enteredPassword = '';
  var isAuthentication = false;
  final _formKey = GlobalKey<FormState>();
  void submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isAuthentication = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail, password: enteredPassword);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication error")));
    }

    setState(() {
      isAuthentication = false;
    });
    if (context.mounted) Navigator.pop(context);
  }

  void signUpClick() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
                      'Welcome Back Comrade!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Let\'s get going with the game',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
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
                                onSaved: (value) => enteredEmail = value!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 6) {
                                    return 'Passwords should consist of atleast 6 characters';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Password',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                onSaved: (value) => enteredPassword = value!,
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
                                  'Login',
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
                                Text(
                                  'Don\'t have an account?',
                                ),
                                TextButton(
                                  onPressed: signUpClick,
                                  child: Text(
                                    'Sign up',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
