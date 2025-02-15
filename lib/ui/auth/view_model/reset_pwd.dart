import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/repositories.dart';
import 'package:my_flutter_mvvm_template/utils/validators.dart';

class ResetPwdViewModel {
  ResetPwdViewModel(this._authRepository) {
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  final AuthRepository _authRepository;

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

  Future<void> resetPassword(BuildContext context) async {
    isLoading.value = true;

    String email = emailController.text;
    String password = passwordController.text;

    final res = await _authRepository.resetPassword(email);

    isLoading.value = false;

    if (res is Error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text((res as Error).toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushNamed(context, '/validateOTP',
          arguments: {'email': email, 'password': password});
    }
  }

  Future<void> confirmOTP() async {
    String email = emailController.text;
    String otp = passwordController.text;
    String newPassword = confirmPasswordController.text;

    isLoading.value = true;

    await _authRepository.changePwd(email, otp, newPassword);

    isLoading.value = false;
  }
}
