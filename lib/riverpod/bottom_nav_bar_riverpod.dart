import 'package:flutter/cupertino.dart';
import 'package:spece_man/view/basket/basket.dart';
import 'package:spece_man/view/favorite/favorite.dart';
import 'package:spece_man/view/home/home.dart';
import 'package:spece_man/view/Profile/profile.dart';

class BottomNavBarRiverpod extends ChangeNotifier {
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home,color: CupertinoColors.black,), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart,color: CupertinoColors.black), label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag,color: CupertinoColors.black), label: "Bag" ),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person,color: CupertinoColors.black), label: "Profile"),
  ];

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

    String appbarTitle() {
    switch (currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Favorites";
      case 2:
        return "Bag";
      case 3:
        return "Profile";
      default:
        return "Boş";
    }
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return Home();
      case 1:
        return Favorite();
      case 2:
        return Basket();
      case 3:
        return Profile();
      default:
        return Home();
    }
  }
}
