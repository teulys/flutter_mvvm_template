import 'package:my_flutter_mvvm_template/domain/models/models.dart';
import 'package:my_flutter_mvvm_template/utils/result.dart';

abstract class AuthService {
  Future<Result<Sessions>> signInWithEmailAndPassword(
      String email, String password);
  Future<Result<Users>> signUpWithEmailAndPassword(
      String email, String password);
  Future<Result<Sessions?>> signInWithGoogle();
  Future<Result<Sessions>> verifyOTP(String email, String otp);
  Future<Result<String>> verifyOTPAndResetPassword(
      String email, String otp, String newPassword);
  Future<void> signOut();
  Future<Result<String>> sendResetPasswordOTP(String email);
}
