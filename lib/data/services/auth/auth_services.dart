import 'package:my_flutter_mvvm_template/domain/models/session.dart';

abstract class AuthService {
  Future<Sessions?> signInWithEmailAndPassword(String email, String password);
  Future<Sessions?> signUpWithEmailAndPassword(String email, String password);
  Future<Sessions?> signInWithGoogle();
  Future<Sessions?> verifyOTP(String email, String otp);
  Future<Sessions?> resetPassword(String email);
  Future<void> signOut();
  Future<void> resendOTP(String email);
}
