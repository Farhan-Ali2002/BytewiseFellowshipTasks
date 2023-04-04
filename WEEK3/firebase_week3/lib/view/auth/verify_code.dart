import 'package:firebase_week3/utils/utils.dart';
import 'package:firebase_week3/view/posts/postscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week3/widgets/roundbutton.dart';

class VerifyCode extends StatefulWidget {
  final String verificationnId;
  const VerifyCode({super.key, required this.verificationnId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final codeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _Formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
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
                  return 'code cannot be empty';
                } else {
                  return null;
                }
              },
              controller: codeController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'six digit code',
                  hintStyle: TextStyle()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoundButton(
              loading: loading,
              title: "Verify",
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationnId,
                    smsCode: codeController.text.toString());

                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Postscreen()));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  utils().showToastMsg(e.toString());
                }
              })
        ]),
      ),
    );
  }
}
