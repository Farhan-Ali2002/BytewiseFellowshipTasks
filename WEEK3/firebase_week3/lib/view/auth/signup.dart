import 'package:flutter/material.dart';
import '../../widgets/roundbutton.dart';
import 'Loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/utils.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _Formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signuP() {
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      utils().showToastMsg(error.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _Formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            loading = false;
                          });
                          return 'Please Enter Email';
                        } else if (!RegExp(
                                r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                            .hasMatch(value)) {
                          setState(() {
                            loading = false;
                          });
                          return 'Please enter a valid Email';
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          hintStyle: TextStyle()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            loading = false;
                          });
                          return 'Please Enter Password';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          hintText: 'Password',
                          hintStyle: TextStyle()),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            RoundButton(
                title: 'Sign Up',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  if (_Formkey.currentState!.validate()) {
                    signuP();
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 103, 175), fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Login!',
                      style:
                          TextStyle(color: Color.fromARGB(255, 14, 103, 175)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
