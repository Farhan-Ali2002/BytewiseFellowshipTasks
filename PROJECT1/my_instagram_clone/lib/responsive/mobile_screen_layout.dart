import 'package:flutter/material.dart';
import 'package:my_instagram_clone/utils/colors.dart';
import 'package:my_instagram_clone/utils/global_variables.dart';

class MobileViewWidget extends StatefulWidget {
  const MobileViewWidget({super.key});

  @override
  State<MobileViewWidget> createState() => _MobileViewWidgetState();
}

class _MobileViewWidgetState extends State<MobileViewWidget> {
  String username = "";
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // getUserName();
  }

  @override
  void dispose() {
    _pageController.dispose();
  }

  // void getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }
  int _page = 0;
  late PageController _pageController;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(
                  color: _page == 1 ? primaryColor : secondaryColor,
                  Icons.search,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  color: _page == 2 ? primaryColor : secondaryColor,
                  Icons.add_circle,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  color: _page == 3 ? primaryColor : secondaryColor,
                  Icons.favorite,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  color: _page == 4 ? primaryColor : secondaryColor,
                  Icons.person,
                ),
                label: "")
          ],
          onTap: navigationTapped,
        ),
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
            controller: _pageController,
            children: homeScreenItems));
  }
}
