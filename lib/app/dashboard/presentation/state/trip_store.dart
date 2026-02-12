import 'package:flutter/material.dart';

class Trip {
  Trip({
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required List<String> interests,
    DateTime? createdAt,
  })  : interests = List.unmodifiable(interests),
        createdAt = createdAt ?? DateTime.now();

  final String title;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String budget;
  final List<String> interests;
  final DateTime createdAt;

  bool get ready => interests.isNotEmpty;

  bool get isHighPriority => budget.toLowerCase() == 'high';

  String get dateRangeLabel {
    final startMonth = _monthName(startDate.month);
    final endMonth = _monthName(endDate.month);

    if (startDate.year == endDate.year) {
      if (startDate.month == endDate.month) {
        return '$startMonth ${startDate.day} - ${endDate.day}, ${startDate.year}';
      }
      return '$startMonth ${startDate.day} - $endMonth ${endDate.day}, ${startDate.year}';
    }

    return '$startMonth ${startDate.day}, ${startDate.year} - '
        '$endMonth ${endDate.day}, ${endDate.year}';
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[(month - 1).clamp(0, months.length - 1)];
  }
}

class TripStore extends ChangeNotifier {
  TripStore({List<Trip>? initialTrips})
      : _trips = List<Trip>.from(initialTrips ?? const []);

  final List<Trip> _trips;

  List<Trip> get trips => List.unmodifiable(_trips);

  bool get isEmpty => _trips.isEmpty;

  void addTrip(Trip trip) {
    _trips.insert(0, trip);
    notifyListeners();
  }
}

class TripScope extends InheritedNotifier<TripStore> {
  const TripScope({
    super.key,
    required TripStore notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static TripStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<TripScope>();
    assert(scope != null, 'TripScope not found in the widget tree.');
    return scope!.notifier!;
  }
}
