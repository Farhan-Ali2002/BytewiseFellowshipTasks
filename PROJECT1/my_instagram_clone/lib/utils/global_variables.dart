import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("favourite")),
  Center(child: Text("account")),
];
