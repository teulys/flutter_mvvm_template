import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/repositories.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel(this._repository) {
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  final AuthRepository _repository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> isPasswordValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isConfirmPasswordValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isMailValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isFormValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void _validateForm() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final email = emailController.text;

    isPasswordValid.value = _validatePassword(password);
    isConfirmPasswordValid.value =
        password == confirmPassword && confirmPassword.isNotEmpty;
    isMailValid.value = _validateEmail(email);

    isFormValid.value = isPasswordValid.value &&
        isConfirmPasswordValid.value &&
        isMailValid.value;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasMinLength = password.length >= 8;

    return hasUppercase && hasLowercase && hasDigits && hasMinLength;
  }

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    // Implement the sign up with email and password

    if (isMailValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value) {
      isLoading.value = true;

      await _repository.signUpWithEmailAndPassword(
          emailController.text, passwordController.text);

      isLoading.value = false;

      Navigator.pushNamed(context, '/validateOTP', arguments: {
        'email': emailController.text,
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('validateForm'.tr()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  )
                ],
              ));
    }
  }

  Future<void> goToSingIn(BuildContext context) async {
    Navigator.pushNamed(context, '/signIn');
  }
}
