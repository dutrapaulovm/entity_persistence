import 'dart:convert';

import 'package:entity_persistence/entity_persistence.dart';

class User extends Entity {
  String? name;
  String? login;
  String? email;
  String? password;
  User({
    this.name,
    this.login,
    this.email,
    this.password,
  });

  User copyWith({
    String? name,
    String? login,
    String? email,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      login: login ?? this.login,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'login': login,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : null,
      login: map['login'] != null ? map['login'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(name: $name, login: $login, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.login == login &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ login.hashCode ^ email.hashCode ^ password.hashCode;
  }

  @override
  String get entityName => "usuario";

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return User.fromMap(map);
  }
}
