import 'package:easy_localization/easy_localization.dart';
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
  Future<Sessions?> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
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
  Future<Sessions?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<Result<Sessions>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password);

      Sessions? session = _mapSession(res);

      if (session != null) {
        return Result.ok(session);
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

    return (user != null)
        ? Users(
            id: user.id,
            aud: user.aud,
            email: user.email ?? '',
            role: user.role,
          )
        : null;
  }

  @override
  Future<void> resendOTP(String email) async {
    await supabase.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }
}
