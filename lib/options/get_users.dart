import 'dart:convert';
import 'dart:developer';
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fgh/ip.dart';
import 'package:http/http.dart' as http;

class GetUsers {
  // final _auth = FirebaseAuth.instance;

  String url = "http://$ip:3001";

  Future getUsers() async {
    try {
      List answer= [];
      await http.get(
        Uri.parse('$url/get_users'),
      ).then((r)=>answer = jsonDecode(r.body));
      print(answer);

      return answer;
    } catch (e) {
      // print('Something went wrong');
      log("Something went wrong");
    }
  }

  // Future loginUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     int answer = 0;
  //     await http.post(
  //       Uri.parse('$url/login'),
  //       body: {"email": email, "password": password, "last_online_dt": DateTime.now().millisecondsSinceEpoch.toString()}
  //     ).then((r)=>answer = int.parse(r.body));
  //     // final cred = await _auth.signInWithEmailAndPassword(
  //     //     email: email, password: password);

  //     return answer;
  //   } catch (e) {
  //     log("Something went wrong");
  //     return 0;
  //   }
  // }

  // Future<void> signout() async {
  //   try {
  //     // await _auth.signOut();
  //   } catch (e) {
  //     // log("Something went wrong");
  //   }
  // }
}