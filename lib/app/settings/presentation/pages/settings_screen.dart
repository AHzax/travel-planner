import 'package:clean_architecture_app/app/auth/presentation/pages/sign_in_page.dart';
import 'package:clean_architecture_app/app/settings/presentation/pages/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/setting';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool tripReminder = false;
  bool dailyAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBar(),
            const SizedBox(height: 24),
            _sectionTitle("NOTIFICATIONS"),
            _Card(
              children: [
                _SwitchTile(
                  iconGradient: const [Color(0xFF1A73E8), Color(0xFF3A8DFF)],
                  title: "Trip Reminders",
                  subtitle: "Get notified before trip starts",
                  value: tripReminder,
                  onChanged: (v) => setState(() => tripReminder = v),
                ),
                const Divider(),
                _SwitchTile(
                  iconGradient: const [Color(0xFF00B4A0), Color(0xFF3DDAD7)],
                  title: "Daily Itinerary Alerts",
                  subtitle: "Morning reminder of daily plans",
                  value: dailyAlert,
                  onChanged: (v) => setState(() => dailyAlert = v),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _sectionTitle("ACCOUNT"),
            const _Card(
              children: [
                _AccountTile(),
              ],
            ),
            const SizedBox(height: 28),
            _sectionTitle("ABOUT"),
            const _Card(
              children: [
                _ArrowTile(title: "Privacy Policy"),
                Divider(),
                _ArrowTile(title: "Terms of Service"),
                Divider(),
                _ArrowTile(
                  title: "Version",
                  trailingText: "1.0.0",
                  showArrow: false,
                ),
              ],
            ),
            const SizedBox(height: 28),
            _sectionTitle("DANGER ZONE", color: Colors.red),
            _Card(
              borderColor: Colors.red.withOpacity(0.4),
              children: const [
                _LogoutTile(),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, {Color color = Colors.grey}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

/// ---------------- TOP BAR ----------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 40, left: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A73E8), Color(0xFF00B4A0)],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          const Text(
            "Settings",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- CARD ----------------
class _Card extends StatelessWidget {
  final List<Widget> children;
  final Color? borderColor;

  const _Card({required this.children, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor ?? Colors.blue.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
            )
          ],
        ),
        child: Column(children: children),
      ),
    );
  }
}

/// ---------------- SWITCH TILE ----------------
class _SwitchTile extends StatelessWidget {
  final List<Color> iconGradient;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.iconGradient,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: iconGradient),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// ---------------- ACCOUNT ----------------
class _AccountTile extends StatelessWidget {
  const _AccountTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, EditProfileScreen.routeName),
      contentPadding: const EdgeInsets.all(16),
      leading: Container(
        height: 48,
        width: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF1A73E8), Color(0xFF00B4A0)],
          ),
        ),
        child: const Center(
          child: Text(
            "JD",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: const Text(
        "John Doe",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text("john.doe@example.com"),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

/// ---------------- ARROW TILE ----------------
class _ArrowTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final bool showArrow;

  const _ArrowTile({
    required this.title,
    this.trailingText,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: showArrow
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingText != null)
                  Text(trailingText!,
                      style: const TextStyle(color: Colors.grey)),
                const Icon(Icons.chevron_right),
              ],
            )
          : Text(
              trailingText ?? "",
              style: const TextStyle(color: Colors.grey),
            ),
    );
  }
}

/// ---------------- LOGOUT ----------------
class _LogoutTile extends StatelessWidget {
  const _LogoutTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.pushReplacementNamed(context, SignInPage.routeName),
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        "Log Out",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
