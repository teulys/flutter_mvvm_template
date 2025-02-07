import 'package:flutter/material.dart';

class SignOptionsViewModel {
  void signUp(BuildContext context) {
    Navigator.pushNamed(context, '/signUp');
  }

  void signIn(BuildContext context) {
    Navigator.pushNamed(context, '/signIn');
  }
}
