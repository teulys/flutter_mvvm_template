import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/repositories.dart';
import 'package:my_flutter_mvvm_template/utils/validators.dart';

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

    isPasswordValid.value = ValidatePassword(password);
    isConfirmPasswordValid.value =
        password == confirmPassword && confirmPassword.isNotEmpty;
    isMailValid.value = ValidateEmail(email);

    isFormValid.value = isPasswordValid.value &&
        isConfirmPasswordValid.value &&
        isMailValid.value;
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
