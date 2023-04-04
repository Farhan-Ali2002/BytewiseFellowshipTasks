import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week3/utils/utils.dart';
import 'package:firebase_week3/view/auth/verify_code.dart';
import 'package:firebase_week3/widgets/roundbutton.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _Formkey = GlobalKey<FormState>();

  void loginwithphone() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (_) {
          utils().showToastMsg("Redirecting");
          setState(() {
            loading = false;
          });
        },
        verificationFailed: (e) {
          setState(() {
            loading = false;
          });
          utils().showToastMsg(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyCode(
                        verificationnId: verificationId,
                      )));
          setState(() {
            loading = false;
          });
        },
        codeAutoRetrievalTimeout: (e) {
          utils().showToastMsg(e.toString());
          setState(() {
            loading = false;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Form(
            key: _Formkey,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    loading = false;
                  });
                  return 'phone number cannot be empty';
                } else if (!RegExp(
                        r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")
                    .hasMatch(value)) {
                  setState(() {
                    loading = false;
                  });
                  return 'Please enter a valid phone number';
                } else {
                  return null;
                }
              },
              controller: phoneController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Phone No',
                  hintStyle: TextStyle()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoundButton(
              loading: loading,
              title: "Login",
              onTap: () {
                setState(() {
                  loading = true;
                });
                if (_Formkey.currentState!.validate()) {
                  loginwithphone();
                }
              })
        ]),
      ),
    );
  }
}
