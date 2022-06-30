import 'package:farmasi/pages/shared/Login_Apoteker.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView:  toggleView);
    } else {
      return LoginApoteker(toggleView:  toggleView);
    }
  }
}
