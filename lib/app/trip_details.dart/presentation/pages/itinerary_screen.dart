import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/day_map_screen.dart';
import 'package:flutter/material.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});
  static const routeName = '/itinerary';

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: Column(
          children: [
            _header(context),

            ////////////////////////////////////////////////////////////////
            /// TAB BAR (FIXED)
            ////////////////////////////////////////////////////////////////

            Container(
              height: 72,
              color: Colors.white,
              alignment: Alignment.center,
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab, // important
                indicatorPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E6BF1), Color(0xFF00BFA6)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                tabs: [
                  Tab(child: _TabContent(day: 'Day 1', date: 'Mon, Jun 15')),
                  Tab(child: _TabContent(day: 'Day 2', date: 'Tue, Jun 16')),
                  Tab(child: _TabContent(day: 'Day 3', date: 'Wed, Jun 17')),
                ],
              ),
            ),

            ////////////////////////////////////////////////////////////////
            /// TAB VIEW
            ////////////////////////////////////////////////////////////////

            const Expanded(
              child: TabBarView(
                children: [
                  _DayActivitiesView(),
                  _DayActivitiesView(),
                  _DayActivitiesView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// HEADER
////////////////////////////////////////////////////////////////////////

Widget _header(BuildContext context) {
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
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summer in Paris',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Paris, France',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.map_outlined, color: Colors.white),
      ],
    ),
  );
}

////////////////////////////////////////////////////////////////////////
/// TAB LABEL CONTENT (FIXED HEIGHT)
////////////////////////////////////////////////////////////////////////

class _TabContent extends StatelessWidget {
  final String day;
  final String date;

  const _TabContent({
    required this.day,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // forces indicator to fully wrap
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// DAY ACTIVITIES VIEW
////////////////////////////////////////////////////////////////////////

class _DayActivitiesView extends StatelessWidget {
  const _DayActivitiesView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: const [
        _ActivityCard(
          index: 1,
          title: 'Eiffel Tower',
          time: '09:00 AM',
          note: 'Book tickets in advance. Visit early to avoid crowds.',
        ),
        SizedBox(height: 16),
        _ActivityCard(
          index: 2,
          title: 'Trocadéro Gardens',
          time: '11:30 AM',
          note: 'Perfect spot for photos of the Eiffel Tower.',
        ),
        SizedBox(height: 16),
        _ActivityCard(
          index: 3,
          title: "Lunch at Café de l'Homme",
          time: '01:00 PM',
          note: 'Great views of the tower while dining.',
        ),
        SizedBox(height: 16),
        _ActivityCard(
          index: 4,
          title: 'Seine River Cruise',
          time: '03:00 PM',
          note: 'Relaxing way to see the city from water.',
        ),
        SizedBox(height: 16),
        _ActivityCard(
          index: 5,
          title: 'Notre-Dame Cathedral',
          time: '05:00 PM',
          note: 'Admire the Gothic architecture (exterior only).',
        ),
        SizedBox(height: 24),
        _DailyTipsCard(),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// ACTIVITY CARD
////////////////////////////////////////////////////////////////////////

class _ActivityCard extends StatelessWidget {
  final int index;
  final String title;
  final String time;
  final String note;

  const _ActivityCard({
    required this.index,
    required this.title,
    required this.time,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DayMapScreen.routeName),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: const Border(
            left: BorderSide(color: Color(0xFF00BFA6), width: 4),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E6BF1), Color(0xFF00BFA6)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: Color(0xFF00BFA6)),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF00BFA6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2F7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      note,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// DAILY TIPS
////////////////////////////////////////////////////////////////////////

class _DailyTipsCard extends StatelessWidget {
  const _DailyTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1DD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber),
      ),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 Daily Tips',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 12),
          Text('• Wear comfortable walking shoes'),
          Text('• Bring water and snacks'),
          Text('• Check opening hours before visiting'),
          Text('• Book popular attractions in advance'),
        ],
      ),
    );
  }
}
