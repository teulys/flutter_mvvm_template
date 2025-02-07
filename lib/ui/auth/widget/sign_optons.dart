import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/auth/view_model/sign_options.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';

class SignOptionsView extends StatelessWidget {
  const SignOptionsView({super.key, required this.viewModel});

  final SignOptionsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme().linearGradient,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/bnb_logo.png'),
              Text("BnB Manager",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              CustomButton()
                  .darkButton(('singIn').tr(), () => viewModel.signIn(context)),
              SizedBox(height: 20),
              CustomButton().lightButton(
                  ('singUp').tr(), () => viewModel.signUp(context)),
            ],
          ),
        ),
      ),
    );
  }
}
