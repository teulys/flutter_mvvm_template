import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_flutter_mvvm_template/data/repositories/repositories.dart';
import 'package:my_flutter_mvvm_template/data/services/services.dart';
import 'package:my_flutter_mvvm_template/ui/auth/view_model/sign_options.dart';
import 'package:my_flutter_mvvm_template/ui/core/theme/app_theme.dart';

import 'package:my_flutter_mvvm_template/ui/view_model.dart';
import 'package:my_flutter_mvvm_template/ui/widgets.dart';
import 'package:my_flutter_mvvm_template/utils/cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Cache().init();
  await dotenv.load(fileName: ".env");
  dotenv.env['VAR_NAME'];

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];

// final supabase = SupabaseClient(
//   supabaseUrl!, // URL de tu proyecto
//   supabaseKey!, // Clave pública
// );

  await Supabase.initialize(url: supabaseUrl!, anonKey: supabaseKey!);

  bool isDarkMode = await Cache.readData('isDarkMode') as bool? ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(isDarkMode: isDarkMode)),
      ],
      child: EasyLocalization(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('es', 'ES'),
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final AuthService authService = AuthSupabaseService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: MyTheme().lightTheme,
      darkTheme: MyTheme().darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      initialRoute: '/signOptions',
      //home: HomeWidget(viewModel: HomeViewModel(isDarkMode: isDarkMode)),
      routes: {
        '/home': (context) =>
            HomeWidget(viewModel: HomeViewModel(isDarkMode: isDarkMode)),
        '/signOptions': (context) =>
            SignOptionsView(viewModel: SignOptionsViewModel()),
        '/signIn': (context) =>
            Login(viewModel: SignInViewModel(AuthRepository(authService))),
        '/signUp': (context) =>
            SignUp(viewModel: SignUpViewModel(AuthRepository(authService))),
        '/validateOTP': (context) => ValidateOpt(
            viewModel: ValidateOptViewModel(AuthRepository(authService))),
      },
    );
  }
}
