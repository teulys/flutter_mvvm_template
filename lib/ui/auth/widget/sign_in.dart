import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/auth/view_model/sign_in.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key, required this.viewModel});

  final SignInViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme().linearGradient,
        ),
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BnB Manager",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              customField(
                  text: 'exampleEmail'.tr(),
                  label: 'emailAdr'.tr(),
                  icon: Icons.email,
                  controller: viewModel.emailController),
              customField(
                  text: '**********',
                  label: 'password'.tr(),
                  icon: Icons.email,
                  isPassword: true,
                  controller: viewModel.passwordController),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 40),
                child: Text('forgotPassword'.tr(),
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              CustomButton().darkButton(('singIn').tr(),
                  () => viewModel.signInWithEmailAndPassword()),
              SizedBox(height: 10),
              Text('orLoginWith'.tr(), style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              CustomButton().darkButtonWithImage(
                  'assets/images/google_logo.png',
                  'oogle',
                  () => viewModel.signInWithEmailAndPassword()),
            ],
          ),
        ),
      ),
    );
  }
}
