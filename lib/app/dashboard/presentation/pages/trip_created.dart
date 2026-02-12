import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/trip_sumary_screen.dart';
import 'package:flutter/material.dart';
import '../state/trip_store.dart';

class TripCreatedSuccessScreen extends StatelessWidget {
  const TripCreatedSuccessScreen({
    super.key,
    required this.trip,
  });

  final Trip trip;

  String get tripName => trip.title;

  static const routeName = '/tripCreated';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E6BF1), Color(0xFF00BFA6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: Column(
              children: [
                const Spacer(),
                _successIcon(),
                const SizedBox(height: 32),
                _title(),
                const SizedBox(height: 12),
                _subtitle(),
                const Spacer(),
                _primaryButton(context),
                const SizedBox(height: 16),
                _secondaryButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────── ICON ─────────────────

  Widget _successIcon() {
    return Container(
      height: 96,
      width: 96,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          size: 36,
          color: Colors.green,
        ),
      ),
    );
  }

  // ───────────────── TEXT ─────────────────

  Widget _title() {
    return const Text(
      'Trip Created!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subtitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: tripName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextSpan(
            text: '\n\nis ready to plan',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  // ───────────────── BUTTONS ─────────────────

  Widget _primaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TripSummaryScreen(trip: trip),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'View Trip Details',
          style: TextStyle(
            color: Color(0xFF1E6BF1),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.home_outlined,
          color: Colors.white,
        ),
        label: const Text(
          'Back to Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.6),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
