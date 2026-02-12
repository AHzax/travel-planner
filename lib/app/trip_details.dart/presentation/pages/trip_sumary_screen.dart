import 'package:clean_architecture_app/app/dashboard/presentation/pages/dashboard_page.dart';
import 'package:clean_architecture_app/app/dashboard/presentation/state/trip_store.dart';
import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/itinerary_screen.dart';
import 'package:flutter/material.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({super.key, this.trip});

  static const routeName = '/tripSummary';
  final Trip? trip;

  @override
  Widget build(BuildContext context) {
    final resolvedTrip = trip ?? _latestTrip(context);
    if (resolvedTrip == null) {
      return const _EmptyTripSummary();
    }

    final totalDays =
        resolvedTrip.endDate.difference(resolvedTrip.startDate).inDays + 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Column(
        children: [
          _Header(trip: resolvedTrip),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                children: [
                  _DurationCard(
                    trip: resolvedTrip,
                    totalDays: totalDays,
                  ),
                  const SizedBox(height: 16),
                  _BudgetCard(trip: resolvedTrip),
                  const SizedBox(height: 16),
                  _InterestsCard(trip: resolvedTrip),
                  const SizedBox(height: 16),
                  _PaceCard(totalDays: totalDays),
                ],
              ),
            ),
          ),
          _BottomCTA(
            onTap: () {
              Navigator.pushNamed(context, ItineraryScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  Trip? _latestTrip(BuildContext context) {
    final trips = TripScope.of(context).trips;
    return trips.isEmpty ? null : trips.first;
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E6BF1), Color(0xFF00BFA6)],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  trip.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomCTA extends StatelessWidget {
  const _BottomCTA({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF16A34A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'View Your Itinerary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// REUSABLE CARD STRUCTURE
////////////////////////////////////////////////////////////////////////

class _InfoCard extends StatelessWidget {
  final Color accentColor;
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _InfoCard({
    required this.accentColor,
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// INDIVIDUAL CARDS
////////////////////////////////////////////////////////////////////////

class _DurationCard extends StatelessWidget {
  const _DurationCard({
    required this.trip,
    required this.totalDays,
  });

  final Trip trip;
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      accentColor: const Color(0xFF2563EB),
      icon: Icons.calendar_month,
      title: 'Duration',
      children: [
        Text(
          '${_dateLabel(trip.startDate)} -> ${_dateLabel(trip.endDate)}',
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 8),
        _Tag(
          label: '$totalDays ${totalDays == 1 ? 'day' : 'days'}',
          color: const Color(0xFF2563EB),
        ),
      ],
    );
  }

  String _dateLabel(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _BudgetCard extends StatelessWidget {
  const _BudgetCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      accentColor: const Color(0xFF059669),
      icon: Icons.attach_money,
      title: 'Budget',
      children: [
        _Tag(
          label: trip.budget,
          color: const Color(0xFF059669),
        ),
      ],
    );
  }
}

class _InterestsCard extends StatelessWidget {
  const _InterestsCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      accentColor: const Color(0xFFE11D48),
      icon: Icons.favorite_border,
      title: 'Your Interests',
      children: [
        if (trip.interests.isEmpty)
          const Text(
            'No interests selected for this trip yet.',
            style: TextStyle(color: Colors.black54),
          ),
        if (trip.interests.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: trip.interests
                .map(
                  (interest) => _Tag(
                    label: interest,
                    color: const Color(0xFFE11D48),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _PaceCard extends StatelessWidget {
  const _PaceCard({required this.totalDays});

  final int totalDays;

  @override
  Widget build(BuildContext context) {
    final pace = _paceLabel(totalDays);
    return _InfoCard(
      accentColor: const Color(0xFFF59E0B),
      icon: Icons.flash_on,
      title: 'Travel Pace',
      children: [
        _Tag(label: pace, color: const Color(0xFFF59E0B)),
        const SizedBox(height: 8),
        Text(
          _paceDescription(pace),
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  String _paceLabel(int days) {
    if (days <= 3) {
      return 'Fast';
    }
    if (days <= 7) {
      return 'Balanced';
    }
    return 'Relaxed';
  }

  String _paceDescription(String pace) {
    switch (pace) {
      case 'Fast':
        return 'Short trip with tighter daily plans.';
      case 'Balanced':
        return 'Mix of activity and downtime.';
      default:
        return 'More room for slower, flexible travel days.';
    }
  }
}

////////////////////////////////////////////////////////////////////////
/// TAG WIDGET
////////////////////////////////////////////////////////////////////////

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyTripSummary extends StatelessWidget {
  const _EmptyTripSummary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.map_outlined,
                  color: Color(0xFF1E6BF1),
                  size: 56,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No trip selected',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create a trip first to view your summary details.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      DashboardPage.routeName,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E6BF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Back to Dashboard',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
