import 'package:my_flutter_mvvm_template/data/services/auth/auth_services.dart';
import 'package:my_flutter_mvvm_template/domain/models/models.dart';

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
  Future<Sessions?> signInWithEmailAndPassword(
      String email, String password) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    return _mapSession(res);
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
  Future<Sessions?> signUpWithEmailAndPassword(
      String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return _mapSession(res);
  }

  @override
  Future<Sessions?> verifyOTP(String email, String otp) async {
    final AuthResponse res = await supabase.auth
        .verifyOTP(email: email, token: otp, type: OtpType.signup);

    return _mapSession(res);
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

  @override
  Future<void> resendOTP(String email) async {
    await supabase.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }
}
