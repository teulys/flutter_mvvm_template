import 'package:my_flutter_mvvm_template/domain/models/models.dart';
import 'package:my_flutter_mvvm_template/utils/result.dart';

abstract class AuthService {
  Future<Result<Sessions>> signInWithEmailAndPassword(
      String email, String password);
  Future<Result<Sessions>> signUpWithEmailAndPassword(
      String email, String password);
  Future<Result<Sessions?>> signInWithGoogle();
  Future<Result<Sessions>> verifyOTP(String email, String otp);
  Future<Sessions?> resetPassword(String email);
  Future<void> signOut();
  Future<void> resendOTP(String email);
}
