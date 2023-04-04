import 'package:firebase_week3/utils/utils.dart';
import 'package:firebase_week3/view/posts/addpost.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/Loginscreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase(
          databaseURL:
              "https://fir-week3-34f14-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Post screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  utils().showToastMsg("Logout successfull");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  utils().showToastMsg(error.toString());
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text(
                            "Post : ${snapshot.child('description').value.toString()}"),
                        subtitle: Text(
                            "id : ${snapshot.child('id').value.toString()}"),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
