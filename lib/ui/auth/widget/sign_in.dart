import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key, required this.viewModel});

  final SignInViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppTheme().linearGradient,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                Text("BnB Manager",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: viewModel.isMailValid,
                  builder: (BuildContext context, bool isValue, Widget? child) {
                    return customField(
                        text: 'exampleEmail'.tr(),
                        label: 'emailAdr'.tr(),
                        icon: Icons.email,
                        controller: viewModel.emailController,
                        borderColor: isValue ? Colors.green : Colors.red);
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: viewModel.isPasswordValid,
                    builder:
                        (BuildContext context, bool isValue, Widget? child) {
                      return customField(
                          text: '**********',
                          label: 'password'.tr(),
                          icon: Icons.lock,
                          isPassword: true,
                          controller: viewModel.passwordController,
                          borderColor: isValue ? Colors.green : Colors.red);
                    }),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 40),
                  child: GestureDetector(
                    onTap: () => viewModel.goToForgotPassword(context),
                    child: Text('forgotPassword'.tr(),
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                ValueListenableBuilder(
                    valueListenable: viewModel.isFormValid,
                    builder:
                        (BuildContext context, bool isValue, Widget? child) {
                      return CustomButton().darkButton(
                          ('singIn').tr(),
                          () => isValue
                              ? viewModel.signInWithEmailAndPassword(context)
                              : viewModel.showLoginErrorAlert(context, null));
                    }),
                SizedBox(height: 10),
                Text('orLoginWith'.tr(), style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                CustomButton().darkButtonWithImage(
                    'assets/images/google_logo.png',
                    'oogle',
                    () => viewModel.signInWithGoogle()),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('notHaveAccount'.tr(),
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                        onTap: () => viewModel.goToSignUp(context),
                        child: Text('singUp'.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
