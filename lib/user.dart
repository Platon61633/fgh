class User {
  final String token;
  final String email;
  final String username;

  User({ required this.token, required this.email, required this.username});

  Map<String, dynamic> toMap() {
    return { 'token': token, 'email': email, 'username': username};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'],
      email: map['email'],
      username: map['username'],
    );
  }
}