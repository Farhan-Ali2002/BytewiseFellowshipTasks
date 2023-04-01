import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/roundbutton.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/utils.dart';
import '../posts/postscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _Formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      utils().showToastMsg("Logged in as ${value.user!.email.toString()}");
      setState(() {
        loading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Postscreen()));
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Login"),
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
                  loading: loading,
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    if (_Formkey.currentState!.validate()) {
                      login();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 14, 103, 175), fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()));
                      },
                      child: const Text(
                        'SignUp!',
                        style:
                            TextStyle(color: Color.fromARGB(255, 14, 103, 175)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
