import 'dart:convert';
import 'dart:io';

class Test1 {
  final String username;
  final String password;
  Test1({
    required this.username,
    required this.password,
  });


  Test1 copyWith({
    String? username,
    String? password,
  }) {
    return Test1(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory Test1.fromMap(Map<String, dynamic> map) {
    return Test1(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Test1.fromJson(String source) => Test1.fromMap(json.decode(source));

  @override
  String toString() => 'Test1(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Test1 &&
      other.username == username &&
      other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
