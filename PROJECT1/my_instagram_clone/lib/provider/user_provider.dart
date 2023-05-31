import 'package:flutter/foundation.dart';
import 'package:my_instagram_clone/models/users.dart';
import 'package:my_instagram_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();
  User? _user;
  User get getUser => _user!;

  Future<void> RefreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
