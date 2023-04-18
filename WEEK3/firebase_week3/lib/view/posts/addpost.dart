import 'package:firebase_week3/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../widgets/roundbutton.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final addpostcontroller = TextEditingController();

  bool loading = false;
  final refdatabase = FirebaseDatabase(
          databaseURL:
              "https://fir-week3-34f14-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD POST"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorHeight: 30,
              controller: addpostcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "what's on your mind.....",
                  hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              minLines: 4,
              maxLines: 7,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
                loading: loading,
                title: "Post",
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  final String id =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  refdatabase.child(id).set({
                    'id': id,
                    'description': addpostcontroller.text.toString()
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    addpostcontroller.clear();

                    utils().showToastMsg("Post added successfully");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    utils().showToastMsg(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
