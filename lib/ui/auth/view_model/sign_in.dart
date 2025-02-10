import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/auth_repository.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';
import 'package:my_flutter_mvvm_template/utils/validators.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignInViewModel(this._authRepository) {
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isMailValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPasswordValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isFormValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void _validateForm() {
    final email = emailController.text;
    final password = passwordController.text;

    isMailValid.value = ValidateEmail(email);
    isPasswordValid.value = ValidatePassword(password);
    isFormValid.value = isMailValid.value && isPasswordValid.value;
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    isLoading.value = true;
    String email = emailController.text;
    String password = passwordController.text;
    Result<String> loginSuccess =
        await _authRepository.signInWithEmailAndPassword(email, password);

    if (loginSuccess is Ok) {
      // Navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show an alert dialog
      showLoginErrorAlert(
          context,
          (loginSuccess as Error)
              .error
              .toString()
              .replaceAll('Exception:', ''));
    }
  }

  void showLoginErrorAlert(BuildContext context, String? text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('error'.tr()),
        content: Text((text != null) ? text : 'loginError'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ok'.tr()),
          ),
        ],
      ),
    );
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
