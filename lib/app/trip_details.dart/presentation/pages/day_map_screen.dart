import 'package:flutter/material.dart';

class DayMapScreen extends StatelessWidget {
  const DayMapScreen({super.key});
  static const routeName = '/day-map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Map Background
          Positioned.fill(child: _MapBackground()),

          /// App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopBar(),
          ),

          /// Markers
          _marker(1, 140, 180, blue: true),
          _marker(2, 230, 300),
          _marker(3, 160, 420, blue: true),
          _marker(4, 290, 350),
          _marker(5, 240, 500),

          /// Dashed Path
          Positioned.fill(child: CustomPaint(painter: RoutePainter())),

          /// Zoom Buttons
          Positioned(
            right: 20,
            top: 260,
            child: Column(
              children: [
                _roundButton(Icons.add),
                const SizedBox(height: 10),
                _roundButton(Icons.remove),
              ],
            ),
          ),

          /// Location Button
          Positioned(
            right: 20,
            top: 350,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A73E8), Color(0xFF00B4A0)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.navigation, color: Colors.white),
            ),
          ),

          /// Bottom Sheet
          const Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: PlacesCard(),
          ),
        ],
      ),
    );
  }

  static Widget _marker(int number, double left, double top,
      {bool blue = false}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: blue
                ? [const Color(0xFF1A73E8), const Color(0xFF3A8DFF)]
                : [const Color(0xFF00B4A0), const Color(0xFF3DDAD7)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _roundButton(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          )
        ],
      ),
      child: Icon(icon, color: Colors.blue),
    );
  }
}

/// ---------------- TOP BAR ----------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A73E8), Color(0xFF00B4A0)],
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(width: 12),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Day 1 Map",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Paris, France",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------- MAP GRID ----------------
class _MapBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey.withOpacity(0.08)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ---------------- ROUTE ----------------
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(170, 240)
      ..quadraticBezierTo(80, 380, 170, 520)
      ..quadraticBezierTo(280, 650, 340, 700);

    drawDashedPath(canvas, paint, path);
  }

  void drawDashedPath(Canvas canvas, Paint paint, Path path) {
    const dashWidth = 10;
    const dashSpace = 8;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extract = metric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ---------------- BOTTOM CARD ----------------
class PlacesCard extends StatelessWidget {
  const PlacesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 25,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.teal),
              SizedBox(width: 8),
              Text(
                "5 Places Today",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...[
            "Eiffel Tower",
            "Trocadéro Gardens",
            "Café de l'Homme",
            "Seine River",
            "Notre-Dame Cathedral",
          ].asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Text(
                          "${e.key + 1}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        e.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
