// import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'package:fgh/ip.dart';

// class ClassName {
//   String url = 'http://$ip:3001';

//   Future isOnline(String email, String password) async {
//     try {
//         int answer = 0;
//         await http.post(
//           Uri.parse('$url/status_online'),
//           body: {"email": email, "password": password, "last_online_dt": DateTime.now().millisecondsSinceEpoch.toString(), 'status_online': 1},
//       ).then((r)=>answer = int.parse(r.body));
//       return answer;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }