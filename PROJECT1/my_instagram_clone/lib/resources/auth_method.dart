import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './storage_methods.dart';
import '../models/users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser(
      {required String username,
      required String email,
      required String password,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        // creating users
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl =
            await StorageMethods().uploadToStorage('ProfilePics', file, false);

        //saving other details to firestore
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            // 'file': file,
            followers: [],
            following: [],
            photoUrl: photoUrl);
        await _firestore
            .collection('user')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Success";
      } else {
        res = "Please Enter all the fields";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = "The email is badly formatted";
    //   } else if (err.code == "weak-password") {
    //     res = "password should be atleast 6 characters";
    //   }

    // }
    catch (e) {
      res = e.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
