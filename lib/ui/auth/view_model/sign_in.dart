import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/auth_repository.dart';

class SignInViewModel {
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
    await _authRepository.signInWithGoogle();
  }

  Future<void> forgotPassword() async {
    String email = emailController.text;
    await _authRepository.resetPassword(email);
  }
}
