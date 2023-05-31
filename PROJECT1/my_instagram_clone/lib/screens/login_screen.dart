import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_instagram_clone/utils/colors.dart';
import '../widgets/text_field_input.dart';
import './signup_screen.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/webs_screen_layout.dart';
import 'package:my_instagram_clone/resources/auth_method.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);
    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              mobileViewWidget: MobileViewWidget(),
              webViewWidget: WebViewWidget())));
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
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
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    child: !_isLoading
                        ? const Text(
                            'Log in',
                          )
                        : const CircularProgressIndicator(
                            color: primaryColor,
                          ),
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
                        "Don't have an account?",
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
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Sign Up",
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
