import 'dart:convert';
import 'dart:developer';
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fgh/DB/db_user.dart';
import 'package:fgh/ip.dart';
import 'package:http/http.dart' as http;
import 'package:fgh/user.dart';

class AuthService {
  // final _auth = FirebaseAuth.instance;

  String url = 'http://$ip:3001';

  Future createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      Map result = {};
      int answer = 0;
      await http.post(
        Uri.parse('$url/create_user'),
        body: {"name": name, "email": email, "password": password, "start_dt": DateTime.now().millisecondsSinceEpoch.toString()},
      ).then((r){
        Map data = jsonDecode(r.body);
        answer = data['answer'];
        ToBD(name, email, data['token']);
        print(data['token']);
        // answer = int.parse(r.body.answer);
        // print(r.body)
      });
      print(answer);
      return answer;
    } catch (e) {
      print(e);
      log("Something went wrong");
    }
    return null;
  }

  Future loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      int answer = 0;
      String token = '0';
      await http.post(
        Uri.parse('$url/login'),
        body: {"email": email, "password": password, "last_online_dt": DateTime.now().millisecondsSinceEpoch.toString()}
      ).then((r){
        // print(r.body);
        Map result = jsonDecode(r.body);
        answer = result['answer'];
        if (answer==1) {
          ToBD(result['name'], email, result['token']);
        }
      });
      // final cred = await _auth.signInWithEmailAndPassword(
      //     email: email, password: password);
      return answer;
    } catch (e) {
      print(e);
      log("Something went wrong");
      return 0;
    }
  }

    Future loginUserWithTokenAndEmail(
      String email, String token) async {
    try {
      int answer = 0;
      await http.post(
        Uri.parse('$url/login_with_token'),
        body: {"email": email, "token": token, "last_online_dt": DateTime.now().millisecondsSinceEpoch.toString()}
      ).then((r)=>answer = int.parse(r.body));
      // final cred = await _auth.signInWithEmailAndPassword(
      //     email: email, password: password);
      log('Token');
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

  Future<void> ToBD(String username, String email, String token) async {
    try {
      DB_user.instance.saveUser(User(username: username, email: email, token: token));
      log('Successful add in DB');
    }catch (e){
      print(e);
      // log('tyt');
    }
  }
}