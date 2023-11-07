import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannarController with ChangeNotifier {
  int id = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  void onPageChanged(int newPage) {
    id = newPage;
    notifyListeners();
  }

  QuerySnapshot<Map<String, dynamic>>? banners;

  Future<QuerySnapshot<Map<String, dynamic>>> getBannars() async {
    QuerySnapshot<Map<String, dynamic>> myBanners =
        await FirebaseFirestore.instance.collection('ads').get();
    banners = myBanners;

    return myBanners;
  }
}

class YoutubeLinksController with ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>> getYouTubeLinks() {
    return FirebaseFirestore.instance.collection('youtubeLinks').get();
  }
}
