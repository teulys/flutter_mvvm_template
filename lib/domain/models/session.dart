import 'package:my_flutter_mvvm_template/domain/models/users.dart';

class Sessions {
  final String token;
  final String refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final DateTime? expiresAt;
  final Users? users;

  Sessions({
    required this.token,
    required this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.expiresAt,
    this.users,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    DateTime expiresAt = (json['expiresIn'] != null)
        ? DateTime.now().add(Duration(seconds: json['expiresIn']))
        : DateTime.now();

    return Sessions(
      token: json['token'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
      expiresAt: expiresAt,
      users: json['users'] != null ? Users.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'expiresAt': expiresAt?.toIso8601String(),
      'users': users?.toJson(),
    };
  }
}
