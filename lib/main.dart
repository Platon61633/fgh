// import 'dart:developer';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:fgh/DB/db_user.dart';
import 'package:fgh/auth/login.dart';
import 'package:fgh/home.dart';
import 'package:flutter/material.dart';
// import 'auth/signin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB_user.instance.initDb();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget GoTo = Login();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUser();
  }

  _fetchUser() async{
    await DB_user.instance.getUser().then(
      (user){
        setState(() {
          if (user[0]["token"]=='0') {
            GoTo = Login();
          } else {
            GoTo = Home(email: user[0]["email"]);
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: GoTo,
    );
  }
}

