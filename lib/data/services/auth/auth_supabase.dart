import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_mvvm_template/data/services/auth/auth_services.dart';
import 'package:my_flutter_mvvm_template/domain/models/models.dart';
import 'package:my_flutter_mvvm_template/utils/utils.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseService extends AuthService {
  late SupabaseClient supabase;

  AuthSupabaseService() {
    supabase = Supabase.instance.client;
  }

  @override
  Future<Result<Sessions>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      Sessions? session = _mapSession(res);

      if (session != null) {
        return Result.ok(session);
      } else {
        return Result.error(Exception('invalidSession'.tr()));
      }
    } on AuthApiException catch (e) {
      // Handle specific AuthApiException
      if (e.statusCode == 400) {
        return Result.error(Exception('invalidSession'.tr()));
      } else {
        print('Authentication failed: ${e.message}');
        return Result.error(Exception('authFail'.tr()));
      }
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: ${e.toString()}');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  @override
  Future<Result<Sessions?>> signInWithGoogle() async {
    try {
      await dotenv.load(fileName: ".env");

      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
      final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'];

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        return Result.error(Exception('No Access Token found.'));
      }
      if (idToken == null) {
        return Result.error(Exception('No ID Token found.'));
      }

      final AuthResponse res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      Sessions? session = _mapSession(res);

      if (session != null) {
        return Result.ok(session);
      } else {
        return Result.error(Exception('invalidSession'.tr()));
      }
    } on AuthApiException catch (e) {
      // Handle specific AuthApiException
      if (e.statusCode == 400) {
        return Result.error(Exception('invalidSession'.tr()));
      } else {
        print('Authentication failed: ${e.message}');
        return Result.error(Exception('authFail'.tr()));
      }
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: ${e.toString()}');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<Result<Users>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password);

      Users? user = _mapUser(res);

      if (user != null) {
        return Result.ok(user);
      } else {
        return Result.error(Exception('generalError'.tr()));
      }
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: ${e.toString()}');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  @override
  Future<Result<Sessions>> verifyOTP(String email, String otp) async {
    try {
      final AuthResponse res = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);

      Sessions? session = _mapSession(res);

      if (session != null) {
        return Result.ok(session);
      } else {
        return Result.error(Exception('otpError'.tr()));
      }
    } on AuthApiException catch (e) {
      // Handle specific AuthApiException
      if (e.statusCode == 400) {
        return Result.error(Exception('invalidOTP'.tr()));
      } else {
        print('Authentication failed: ${e.message}');
        return Result.error(Exception('generalError'.tr()));
      }
    } catch (e) {
      // Handle any exceptions
      print('An unexpected error occurred: ${e.toString()}');
      return Result.error(Exception('generalError'.tr()));
    }
  }

  Sessions? _mapSession(AuthResponse res) {
    final Session? session = res.session;
    final User? user = res.user;

    if (session != null) {
      return Sessions(
        token: session.accessToken,
        refreshToken: session.refreshToken ?? '',
        users: (user != null)
            ? Users(
                id: user.id,
                aud: user.aud,
                email: user.email ?? '',
                role: user.role,
              )
            : null,
      );
    } else {
      return null;
    }
  }

  Users? _mapUser(AuthResponse res) {
    final User? user = res.user;

    if (user != null) {
      return Users(
        id: user.id,
        aud: user.aud,
        email: user.email ?? '',
        role: user.role,
      );
    } else {
      return null;
    }
  }

  @override
  Future<Result<String>> sendResetPasswordOTP(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);

      return Result.ok('otpTextMessenge'.tr(args: [email]));
    } catch (e) {
      return Result.error(Exception('generalError'.tr()));
    }
  }

  @override
  Future<Result<String>> verifyOTPAndResetPassword(
      String email, String otp, String newPassword) async {
    try {
      AuthResponse res = await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        email: email,
        token: otp,
      );

      Sessions? session = _mapSession(res);

      if (session != null) {
        // Una vez verificado el OTP, cambiamos la contraseña
        final response = await supabase.auth
            .updateUser(UserAttributes(password: newPassword));

        if (response.user != null) {
          return Result.ok('resetPwdSusses'.tr());
        } else {
          return Result.error(Exception('resetPwdError'.tr()));
        }
      } else {
        return Result.error(Exception('otpError'.tr()));
      }
    } on AuthApiException catch (e) {
      // Handle specific AuthApiException
      if (e.statusCode == 400) {
        return Result.error(Exception('invalidOTP'.tr()));
      } else {
        print('Authentication failed: ${e.message}');
        return Result.error(Exception('generalError'.tr()));
      }
    } catch (e) {
      // Handle any exceptions
      print('An unexpected error occurred: ${e.toString()}');
      return Result.error(Exception('generalError'.tr()));
    }
  }
}
