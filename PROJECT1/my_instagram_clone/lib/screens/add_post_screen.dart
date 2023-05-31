import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_instagram_clone/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import '../provider/user_provider.dart';
import '../resources/firestore_methods.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return _file == null
        ? Container(
            child: Center(
                child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text("Post to"),
              actions: [
                TextButton(
                    onPressed: () => postImage(
                          userProvider.getUser.uid,
                          userProvider.getUser.username,
                          userProvider.getUser.photoUrl,
                        ),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => clearImage(),
              ),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "Enter Desc.......",
                              border: InputBorder.none),
                          maxLines: 4,
                        )),
                    SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                // alignment: FractionalOffset.topCenter,
                                image:
                                    NetworkImage(userProvider.getUser.photoUrl),
                              )),
                            ))),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
