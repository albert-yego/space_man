import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spece_man/riverpod/bottom_nav_bar_riverpod.dart';
import 'package:spece_man/riverpod/product_riverpod.dart';

final bottomNavBarRiverpod =
    ChangeNotifierProvider((_) => BottomNavBarRiverpod());

final productRiverpod = ChangeNotifierProvider((_) => ProductRiverpod());

