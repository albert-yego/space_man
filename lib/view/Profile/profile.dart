import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/riverpod_management.dart';

class Profile extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    var watch = ref.watch(productRiverpod);
    var read = ref.read(productRiverpod);
    return Scaffold(
      body: Center(
        child: Text(
          "profil pages will be here",
              style: TextStyle(backgroundColor: Colors.black),

        ),
      )
    );
  }
}
