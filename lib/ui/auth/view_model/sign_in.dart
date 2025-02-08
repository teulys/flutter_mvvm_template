import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/auth_repository.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignInViewModel(this._authRepository);

  TextEditingController get emailController => TextEditingController();
  TextEditingController get passwordController => TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    String email = emailController.text;
    String password = passwordController.text;
    await _authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      print(e);
      //TODO: show alert dialog
    }
  }

  Future<void> forgotPassword() async {
    try {
      String email = emailController.text;
      await _authRepository.resetPassword(email);
    } catch (e) {
      print(e);
    }
  }

  void goToSignUp(BuildContext context) {
    // Navigate to the sign up page
    Navigator.pushNamed(context, '/signUp');
  }

  void goToForgotPassword(BuildContext context) {
    // Navigate to the forgot password page
    Navigator.pushNamed(context, '/forgot_password');
  }
}
