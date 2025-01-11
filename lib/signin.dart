// import 'dart:developer';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'auth_service.dart';
// import 'package:http/http.dart' as http;
// import 'user.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _auth = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String error_email = '';
  // int _counter = 0;

  void authoriz() {
    print(emailController.text);
    // print(passwordController.text);
  }

  void test(){
    // fetchUser().then((r)=>print(int.parse(r.start_dt)+1));
    // print(DateTime.now().secondsSinceEpoch);
    // print(fetchUser().then((r)=>print(DateTime.fromMillisecondsSinceEpoch(int.parse(r.start_dt)))));
    print(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
  }


  // Future<User> fetchUser() async {
  //   final response = await http.get(Uri.parse("http://192.168.1.52:3001/user/Fin"));

  //   if (response.statusCode == 200) {
  //     // print(jsonDecode(response.body));
  //     // return "salam";
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     // return 'g';
  //     throw Exception('Failed to fetch joke');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.red,
      body: SafeArea(

        child: Container(
          margin: const EdgeInsets.only(bottom: 290),
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
                  input(nameController, 'name'),
                  input(emailController, 'email'),
                  if(error_email!='')Text(error_email, style: TextStyle(color: Colors.red)),
                  input(passwordController, 'password'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all( 16.0),
                child: SizedBox(
                  width: 180,
                  height: 42,
                  child: ElevatedButton(
                      onPressed: _signup,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 18),
                      )
                    )
                  ),
              ),
              TextButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()),), 
                child: 
                Text(
                'I have an account',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                )
              )
                )
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
                    hintText: 'Enter your $text'
                  ),
                ),
              );
  }

   _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(emailController.text, passwordController.text, nameController.text);
    // print(user);
    if (user==1) {
      log("User Created Succesfully");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
      setState(() {
        error_email = '';
      });
      // goToHome(context);
    } else if (user==23505){
      setState(() {
        error_email = 'Такой email уже используется. Используйте другой.';
      });
      log('email error');
    }
    else{
      log("User Not Created");
    }
  }
}
