import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/auth/view_model/reset_pwd.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/theme_manager.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';

class ResetPwdView extends StatelessWidget {
  const ResetPwdView({super.key, required this.viewModel});

  final ResetPwdViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppTheme().linearGradient,
          ),
          child: ValueListenableBuilder(
              valueListenable: viewModel.isLoading,
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return _loading();
                }

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      spacing: 20,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Text('appName'.tr(),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        ValueListenableBuilder(
                            valueListenable: viewModel.isMailValid,
                            builder: (context, isValid, child) {
                              return customField(
                                text: 'exampleEmail'.tr(),
                                label: 'emailAdr'.tr(),
                                icon: Icons.email,
                                controller: viewModel.emailController,
                                borderColor:
                                    isValid ? Colors.green : Colors.red,
                              );
                            }),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.isPasswordValid,
                          builder: (context, isValid, child) {
                            return customField(
                              text: '**********',
                              label: 'password'.tr(),
                              icon: Icons.lock,
                              isPassword: true,
                              controller: viewModel.passwordController,
                              borderColor: isValid ? Colors.green : Colors.red,
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.isConfirmPasswordValid,
                          builder: (context, isValid, child) {
                            return customField(
                              text: '**********',
                              label: 'confirmPassword'.tr(),
                              icon: Icons.lock,
                              isPassword: true,
                              controller: viewModel.confirmPasswordController,
                              borderColor: isValid ? Colors.green : Colors.red,
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        CustomButton().darkButton(
                            ('changePwd').tr(),
                            () => (viewModel.isFormValid.value == true)
                                ? viewModel.resetPassword(context)
                                : null),
                        SizedBox(height: size.height * 0.1),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
