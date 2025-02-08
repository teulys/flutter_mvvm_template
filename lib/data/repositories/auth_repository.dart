import 'package:my_flutter_mvvm_template/data/services/auth/auth_services.dart';
import 'package:my_flutter_mvvm_template/domain/models/session.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _authService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  Future<bool> verifyOTP(String email, String otp) async {
    Sessions? session = await _authService.verifyOTP(email, otp);

    if (session != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> resendOTP(String email) async {
    await _authService.resendOTP(email);
  }
}
