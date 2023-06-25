import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({Key? key}) : super(key: key);

  @override
  State<DecisionTree> createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {
 User? user;
  @override
  void initState(){
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }
  onRefresh(userCred){
    setState(() {
      user = userCred;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (user == null){
      return LoginPage(
        onSignIn: (userCred) => onRefresh(userCred),
      );
    }
    return HomePage(
      onSignOut: (userCred) => onRefresh(userCred),
    );
  }
}
