class Users {
  final String id;
  final String aud;
  final String email;
  final String? name;
  final String? role;
  final String? lastSignInAt;

  Users({
    required this.id,
    required this.aud,
    required this.email,
    this.name,
    this.role,
    this.lastSignInAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      aud: json['aud'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      lastSignInAt: json['lastSignInAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aud': aud,
      'email': email,
      'name': name,
      'role': role,
      'lastSignInAt': lastSignInAt,
    };
  }
}
