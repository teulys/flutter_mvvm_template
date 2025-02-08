import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/data/repositories/auth_repository.dart';

class ValidateOptViewModel extends ChangeNotifier {
  ValidateOptViewModel(this._repository);

  final AuthRepository _repository;
  final TextEditingController otpController = TextEditingController();

  Timer? _timer;
  final ValueNotifier<int> _remainingTime =
      ValueNotifier<int>(120); // 2 minutes in seconds

  ValueNotifier<int> get remainingTime => _remainingTime;

  void startTimer() {
    _remainingTime.value = 120; // Reset to 2 minutes
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> validateOpt(BuildContext context, String mail) async {
    String otp = otpController.text;

    if (otp.length != 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('error'.tr()),
          content: Text('otpError'.tr()),
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
      return;
    }

    startTimer();

    bool isOtpOk = await _repository.verifyOTP(mail, otp);

    if (isOtpOk) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('error'.tr()),
          content: Text('otpError'.tr()),
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
  }

  Future<void> resendOTP(BuildContext context, String mail) async {
    await _repository.resendOTP(mail);
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }
}
