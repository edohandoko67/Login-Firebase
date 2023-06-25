import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/theme.dart';

class LoginPage extends StatefulWidget {
  final Function(User) onSignIn;
  LoginPage({required this.onSignIn});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool login = true;


  Future<void> loginAno() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      print(userCredential.user);
      if (userCredential.user != null) {
        User? user = userCredential.user; // Convert to the expected type
        widget.onSignIn(user!);
      }
    } catch (error) {
      print('Terjadi kesalahan saat login anonim: $error');
    }
  }

  Future<void>loginUser() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
      print(userCredential.user);
      widget.onSignIn(userCredential.user!);
    }catch(error){
      print('Terjadi kesalahan saat login anonim: $error');
    }
  }


  Future<void>createUser() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
      print(userCredential.user);
      widget.onSignIn(userCredential.user!);
    }catch(error){
      print('Terjadi kesalahan saat login anonim: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Center(child: Text('Welcome Back!', style: TitleTextStyle,)),
            ),
            Container(
              width: 270,
              height: 210,
              margin: EdgeInsets.only(top: 48),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/splash.png')
                )
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 90),
              child:
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'EmailAddress@gmail.com',
                  ),
                )
            ),
            Container(
                width: 300,
                margin: EdgeInsets.only(top: 50),
                child:
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: '********',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    )
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ElevatedButton(
                  onPressed: () {
                    loginAno();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff1F59B6)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(300,50))
                  ),
                  child: Text('Login Anonymous') ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                      login? loginUser() : createUser();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff1F59B6)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(300,50))
                  ),
                  child: Text(login ? 'login into account' : 'create user') ),
            )
          ],
        ),
      ),
    );
  }
}