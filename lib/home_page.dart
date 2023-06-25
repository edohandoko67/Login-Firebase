import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/theme.dart';

class HomePage extends StatefulWidget {
  final Function(User) onSignOut;
  HomePage({required this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    widget.onSignOut(null!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Center(child: Text('Welcome', style: TitleTextStyle,)),
            ElevatedButton(
                onPressed: () {
                logout();
            }, style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff1F59B6)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              minimumSize: MaterialStateProperty.all(Size(300, 50))
            ),
                child: Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
