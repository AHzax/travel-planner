import 'package:flutter/material.dart';

class UserSelectionPage extends StatelessWidget {
  const UserSelectionPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Selection Screen'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/sign-in'),
              child: const Text('Go to Sign In'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/register'),
              child: const Text('Go to Register'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/forgot-password'),
              child: const Text('Go to Forgot Password'),
            ),
          ],
        ),
      ),
    );
  }
}
