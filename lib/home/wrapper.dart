import 'package:accassado/home/home.dart';
import 'package:accassado/modules/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authenticate/signin.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
