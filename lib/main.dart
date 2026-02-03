import 'package:flutter/material.dart';

import 'app/auth/presentation/pages/forgot_password_page.dart';
import 'app/auth/presentation/pages/register_page.dart';
import 'app/auth/presentation/pages/sign_in_page.dart';
import 'app/auth/presentation/pages/user_selection_page.dart';
import 'app/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: UserSelectionPage.routeName,
      routes: {
        UserSelectionPage.routeName: (_) => const UserSelectionPage(),
        SignInPage.routeName: (_) => const SignInPage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        ForgotPasswordPage.routeName: (_) => const ForgotPasswordPage(),
        DashboardPage.routeName: (_) => const DashboardPage(),
      },
    );
  }
}
