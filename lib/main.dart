// lib/main.dart
import 'package:flutter/material.dart';
import 'package:right_now/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_now/screens/ai_screen.dart';
import 'package:right_now/screens/cases_screen.dart';
import 'package:right_now/screens/create_password_screen.dart';
import 'package:right_now/screens/discover_screen.dart';
import 'package:right_now/screens/forgot_password_screen.dart';
import 'package:right_now/screens/login_screen.dart';
import 'package:right_now/screens/onboarding_screen.dart';
import 'package:right_now/screens/profile_screen.dart';
import 'package:right_now/screens/root_shell.dart';
import 'package:right_now/screens/signup_screen.dart';
import 'package:right_now/screens/splash_screen.dart';
import 'package:right_now/screens/user_selection_screen.dart';
import 'package:right_now/screens/verify_account_screen.dart';
import 'package:right_now/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeMode initialMode = await ThemeNotifier.loadSavedMode();

  runApp(
    ProviderScope(
      overrides: [
        themeProvider.overrideWith((ref) => ThemeNotifier(initialMode)),
      ],
      child: const RightNow(),
    ),
  );
}

class RightNow extends ConsumerWidget {
  const RightNow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'RightNow',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: themeMode,
      home: const SplashScreen(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/user-selection': (_) => const UserSelectionScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/verify': (_) => const VerifyAccountScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/reset': (_) => const CreatePasswordScreen(),
        '/home': (_) => const RootShell(),
        '/discover': (_) => const DiscoverScreen(),
        '/cases': (_) => const CasesScreen(),
        '/ai': (_) => const AIScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}

ThemeData _lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kPrimaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 19,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: kPrimaryBlue),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryBlue, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      filled: true,
      fillColor: const Color(0xFFF6F7FA),
    ),
    colorScheme: ColorScheme.light(
      primary: kPrimaryBlue,
      secondary: kSecondaryBlue,
      surface: Colors.white,
      background: Colors.grey[50]!,
      onSurface: Colors.black87,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),
  );
}

ThemeData _darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: kPrimaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 19,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: kPrimaryBlue),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryBlue, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
      ),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      labelStyle: TextStyle(color: Colors.grey[400]),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    colorScheme: ColorScheme.dark(
      // primary: kPrimaryBlue,
      // secondary: kSecondaryBlue,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      onSurface: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),
  );
}