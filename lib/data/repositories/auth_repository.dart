import 'package:easy_localization/easy_localization.dart';
import 'package:my_flutter_mvvm_template/data/services/auth/auth_services.dart';
import 'package:my_flutter_mvvm_template/domain/models/models.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';

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

  Future<Result<String>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      Result<Users> sesion =
          await _authService.signUpWithEmailAndPassword(email, password);

      if (sesion is Ok) {
        return Result.ok("Sign up successful");
      } else {
        return Result.error((sesion as Error).error);
      }
    } catch (e) {
      // Handle the error appropriately here
      print('Error signing up: $e');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  Future<Result<String>> resetPassword(String email) async {
    try {
      final res = await _authService.sendResetPasswordOTP(email);

      if (res is Ok) {
        return res;
      } else {
        return Result.error((res as Error).error);
      }
    } catch (e) {
      // Handle the error appropriately here
      print('Error sending reset password OTP: $e');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  Future<Result<String>> verifyOTP(String email, String otp) async {
    Result<Sessions> session = await _authService.verifyOTP(email, otp);

    if (session is Ok) {
      return Result.ok("OTP verified");
    } else {
      return Result.error((session as Error).error);
    }
  }

  Future<Result<String>> signInWithGoogle() async {
    Result<Sessions?> session = await _authService.signInWithGoogle();

    if (session is Ok) {
      return Result.ok("Login successful");
    } else {
      return Result.error((session as Error).error);
    }
  }

  Future<Result<String>> changePwd(
      String email, String otp, String newPass) async {
    try {
      final res =
          await _authService.verifyOTPAndResetPassword(email, otp, newPass);

      if (res is Ok) {
        return res;
      } else {
        return Result.error((res as Error).error);
      }
    } catch (e) {
      // Handle the error appropriately here
      print('Error changing password: $e');
      return Result.error(Exception('generalError'.tr()));
    }
  }
}
