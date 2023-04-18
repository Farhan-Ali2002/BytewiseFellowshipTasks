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
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  bool sure = false;
  final ref = FirebaseDatabase(
          databaseURL:
              "https://fir-week3-34f14-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref('Post');

  Future<void> showMyDialog(String desc, String id) async {
    editController.text = desc;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit"),
            content: Container(
              child: TextField(
                  controller: editController,
                  decoration: const InputDecoration(hintText: "Edit here")),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      'description': editController.text.toString()
                    }).then((value) {
                      utils().showToastMsg("Post Edited Successfully");
                    }).onError((error, stackTrace) {
                      utils().showToastMsg(error.toString());
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Edit")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  Future<void> isSure() async {
    debugPrint("hey i am printing");
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Are You sure you want to delete this?"),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      sure = true;
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      sure = false;
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchFilter,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    size: 30,
                  ),
                ),
                hintText: "Search..",
                border:
                    const OutlineInputBorder(borderSide: BorderSide(width: 4)),
              ),
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final desc = snapshot.child('description').value.toString();
                    if (searchFilter.text.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: ListTile(
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text("Edit"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(desc,
                                        snapshot.child('id').value.toString());
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text("Delete"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await isSure();
                                    if (sure) {
                                      ref
                                          .child(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .remove();
                                    }
                                  },
                                ),
                              )
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                          style: ListTileStyle.list,
                          title: Text(
                              "Post : ${snapshot.child('description').value.toString()}"),
                          subtitle: Text(
                              "id : ${snapshot.child('id').value.toString()}"),
                        ),
                      );
                    } else if (desc
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase())) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: ListTile(
                          style: ListTileStyle.list,
                          title: Text("Post : $desc"),
                          subtitle: Text(
                              "id : ${snapshot.child('id').value.toString()}"),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),
        ],
      ),
    );
  }
}
