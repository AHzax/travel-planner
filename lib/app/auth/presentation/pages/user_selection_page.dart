import 'package:clean_architecture_app/app/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});
  static const routeName = '/';

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardData> _pages = const [
    _OnboardData(
      emoji: '🤖',
      title: 'AI-Powered\nPlanning',
      subtitle:
          'Get personalized itineraries created just for you based on your interests and travel style',
    ),
    _OnboardData(
      emoji: '🗺️',
      title: 'Smart Trip\nSuggestions',
      subtitle:
          'Discover places, activities, and routes optimized for your time and budget',
    ),
    _OnboardData(
      emoji: '✨',
      title: 'Travel Made\nEffortless',
      subtitle:
          'Plan faster, explore smarter, and enjoy every moment without stress',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E6BF1), Color(0xFF00BFA6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _topBar(context),
              Expanded(child: _pageView()),
              _bottomSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────── TOP BAR ─────────────────

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignInPage.routeName),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── PAGE VIEW ─────────────────

  Widget _pageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (index) {
        setState(() => _currentIndex = index);
      },
      itemBuilder: (context, index) {
        final data = _pages[index];
        return _content(data);
      },
    );
  }

  Widget _content(_OnboardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon(data.emoji),
          const SizedBox(height: 32),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(String emoji) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(32),
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 64),
      ),
    );
  }

  // ───────────────── BOTTOM ─────────────────

  Widget _bottomSection(BuildContext context) {
    final isLast = _currentIndex == _pages.length - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        children: [
          _pageIndicator(),
          const SizedBox(height: 24),
          if (isLast) _nextButton(context),
        ],
      ),
    );
  }

  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => _dot(active: index == _currentIndex),
      ),
    );
  }

  Widget _dot({required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: active ? 24 : 6,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white38,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, SignInPage.routeName),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
            color: Color(0xFF1E6BF1),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ───────────────── DATA MODEL ─────────────────

class _OnboardData {
  final String emoji;
  final String title;
  final String subtitle;

  const _OnboardData({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });
}
