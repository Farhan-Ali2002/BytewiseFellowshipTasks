import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_instagram_clone/resources/auth_method.dart';
import 'package:my_instagram_clone/utils/colors.dart';
import '../widgets/text_field_input.dart';
import './login_screen.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? selectedImage;
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUp() async {
    if (selectedImage == null) {
      showSnackBar(context, "Please select a profile pic");
    }
    if (_emailController.text.isEmpty ||
        _passController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      showSnackBar(context, "Error! Fields cannot be empty");
    } else {
      setState(() {
        isLoading = true;
      });

      String res = await AuthMethods().signUpUser(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passController.text,
          bio: _bioController.text,
          file: selectedImage!);
      debugPrint(res);

      if (res != "Success") {
        //    _usernameController.clear();
        // _emailController.clear();
        // _passController.clear();
        // _bioController.clear();
        showSnackBar(context, res);
      } else {
        showSnackBar(context, res);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      selectedImage = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                SvgPicture.asset('assets/images/ic_instagram.svg', height: 64),
                const SizedBox(
                  height: 24,
                ),
                Stack(
                  children: [
                    (selectedImage == null)
                        ? (const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg'),
                          ))
                        : (CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(selectedImage!))),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo)))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    controller: _usernameController,
                    hintText: "Enter Username",
                    textInputType: TextInputType.name),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    controller: _emailController,
                    hintText: "Enter email",
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    isPass: true,
                    controller: _passController,
                    hintText: "Enter password",
                    textInputType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    controller: _bioController,
                    hintText: "Enter your Bio",
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: signUp,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    child: (isLoading)
                        ? const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.white,
                          )
                        : const Text("Sign up"),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Already have an account?",
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      )),
    );
  }
}
