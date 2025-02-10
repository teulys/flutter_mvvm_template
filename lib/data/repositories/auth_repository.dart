import 'package:easy_localization/easy_localization.dart';
import 'package:my_flutter_mvvm_template/data/services/auth/auth_services.dart';
import 'package:my_flutter_mvvm_template/domain/models/models.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<Result<String>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      Result<Sessions> sessions =
          await _authService.signInWithEmailAndPassword(email, password);

      if (sessions is Ok) {
        return Result.ok("Login successful");
      } else {
        return Result.error((sessions as Error).error);
      }
    } catch (e) {
      // Handle the error appropriately here
      print('Error signing in: $e');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _authService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  Future<Result<String>> verifyOTP(String email, String otp) async {
    Result<Sessions> session = await _authService.verifyOTP(email, otp);

    if (session is Ok) {
      return Result.ok("OTP verified");
    } else {
      return Result.error((session as Error).error);
    }
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> resendOTP(String email) async {
    await _authService.resendOTP(email);
  }
}
