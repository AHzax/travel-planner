import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard Screen'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
              child: const Text('Back to Start'),
            ),
          ],
        ),
      ),
    );
  }
}
