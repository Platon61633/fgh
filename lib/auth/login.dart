// import 'dart:developer';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

import 'package:fgh/DB/db_user.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'signin.dart';
import 'auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = AuthService();

  TextEditingController email_Controller = TextEditingController();
  TextEditingController password_Controller = TextEditingController();
  TextEditingController name_Controller = TextEditingController();

  // int _counter = 0;

  void authoriz() {
    print(email_Controller.text);
    // print(password_Controller.text);
  }

  void _loginWithToken(String email, String token)async{
    int status = await _auth.loginUserWithTokenAndEmail(email, token);
    if (status == 1) {
      log("User Login Succesfully");
      print(email);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Home(email: email)),
      );
    }else{
      log('User Not Login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.red,
      body: SafeArea(

        child: Container(
          margin: EdgeInsets.only(bottom: 290),
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
              'Simple', 
                style: TextStyle(
                  fontSize: 40.0,
                  height: 3
                )
              ),
              Column(
                children: <Widget>[
                  input(email_Controller, 'email'),
                  input(password_Controller, 'password'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 180,
                  height: 42,
                  child: ElevatedButton(
                      onPressed: ()=>_login(email_Controller.text, password_Controller.text),
                      child: const Text(
                        'Login',
                        style: const TextStyle(fontSize: 18),
                      )
                    )
                  ),
              ),
              TextButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Signin())), 
                child: 
                Text(
                'I not have an account',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                )
              )
                ),
                // TextButton(onPressed: (){DB_user.instance.deleteUsers();}, child: Text('child'))
            ],
          )
        )
    ),
    );
  }

  Padding input(TextEditingController _controller, String text) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Enter your $text',
                  ),
                ),
              );
  }

  _login(email, password) async {
    log('Login');
    int status = await _auth.loginUserWithEmailAndPassword(email, password);
    if (status == 1) {
      log("User Login Succesfully");
      print(email);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Home(email: email)),
      );
    }else{
      log('User Not Login');
    }
  }
}

// extension on Map<String, dynamic> {
//    get email => null;
//    get password => null;
// }
