import 'package:fgh/DB/db_user.dart';
import 'package:fgh/auth/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String email = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    DB_user.instance.getUser().then(
      (e){
        print(e[0]);
        setState(() {
          email = e[0]['email'];
          username = e[0]['username'];
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('email: $email'),
            Text('username: $username'),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [

            //   ]
            // )
            TextButton(
              onPressed: (){
                DB_user.instance.outUser();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text(
                'Выход',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red
                ),
              ))
          ],
        )
      ),
    ),
    );
  }
}