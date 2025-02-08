import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ValidateOpt extends StatelessWidget {
  const ValidateOpt({super.key, required this.viewModel});

  final ValidateOptViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final String email = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>)['email'] as String;
    final appTheme = AppTheme();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradient =
        isDarkMode ? appTheme.darkGradient : appTheme.linearGradient;

    viewModel.startTimer();

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user,
              size: 150,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'otpTextMessenge'.tr(args: [email]),
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                controller: viewModel.otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                onChanged: (value) {
                  print("OTP ingresado: $value");
                },
                onCompleted: (value) {
                  print("OTP completado: $value");
                  // Puedes validar el OTP aquí
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton().darkButton('verify'.tr(), () {
              viewModel.validateOpt(context, email);
            }),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: viewModel.remainingTime,
              builder: (BuildContext context, dynamic value, Widget? child) {
                String text = (value <= 0 || value == 120)
                    ? 'resend'.tr()
                    : 'remaingOtp'.tr(args: ['$value']);

                return GestureDetector(
                  onTap: () {
                    if (value <= 0 || value == 120) {
                      viewModel.resendOTP(context, email);
                    } else {
                      null;
                    }
                  },
                  child:
                      Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
