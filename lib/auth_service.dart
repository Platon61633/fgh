import 'dart:developer';
import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // final _auth = FirebaseAuth.instance;

  String url = "http://192.168.1.52:3001";

  Future createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      int answer = 0;
      await http.post(
        Uri.parse('$url/create_user'),
        body: {"name": name, "email": email, "password": password, "start_dt": DateTime.now().millisecondsSinceEpoch.toString()},
      ).then((r)=>answer = int.parse(r.body));
      print(answer);
      return answer;
    } catch (e) {
      // print('Something went wrong');
      log("Something went wrong");
    }
    return null;
  }

  Future loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      int answer = 0;
      await http.post(
        Uri.parse('$url/login'),
        body: {"email": email, "password": password, "last_online_dt": DateTime.now().millisecondsSinceEpoch.toString()}
      ).then((r)=>answer = int.parse(r.body));
      print(answer);
      // final cred = await _auth.signInWithEmailAndPassword(
      //     email: email, password: password);

      return answer;
    } catch (e) {
      log("Something went wrong");
      return 0;
    }
  }

  Future<void> signout() async {
    try {
      // await _auth.signOut();
    } catch (e) {
      // log("Something went wrong");
    }
  }
}