import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spece_man/components/bottom_nav_bar.dart';
import 'package:spece_man/riverpod/riverpod_management.dart';

import '../../constants/constants.dart';
import '../../riverpod/bottom_nav_bar_riverpod.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends ConsumerState<BaseScaffold> {
  @override
  void initState() {
    ref.read(productRiverpod).init();
    setState(() {});
    super.initState();
    if (FirebaseAuth.instance.currentUser!.displayName == null) {
      updater();
    }
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(bottomNavBarRiverpod);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: appbarBuild(watch),
      body: watch.body(),
    );
  }

  CupertinoNavigationBar appbarBuild(BottomNavBarRiverpod watch) {
    return CupertinoNavigationBar(
      middle: Text(
        watch.appbarTitle(),
      ),
    );
  }
}
