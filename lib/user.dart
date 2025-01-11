class User {
  int id;
  String name;
  String email;
  String start_dt;
  String last_online;

User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        email = json['email'] as String,
        start_dt = json['start_dt'] as String,
        last_online = json['last_online'] as String;
}