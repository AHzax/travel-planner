import 'package:clean_architecture_app/app/settings/presentation/pages/edit_profile_screen.dart';
import 'package:clean_architecture_app/app/settings/presentation/pages/settings_screen.dart';
import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/day_map_screen.dart';
import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/itinerary_screen.dart';
import 'package:clean_architecture_app/app/trip_details.dart/presentation/pages/trip_sumary_screen.dart';
import 'package:flutter/material.dart';

import 'app/auth/presentation/pages/forgot_password_page.dart';
import 'app/auth/presentation/pages/register_page.dart';
import 'app/auth/presentation/pages/sign_in_page.dart';
import 'app/auth/presentation/pages/user_selection_page.dart';
import 'app/dashboard/presentation/pages/dashboard_page.dart';
import 'app/dashboard/presentation/pages/create_new_trip_page.dart';
import 'app/dashboard/presentation/state/trip_store.dart';

void main() {
  runApp(MainApp(tripStore: TripStore()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.tripStore});

  final TripStore tripStore;

  @override
  Widget build(BuildContext context) {
    return TripScope(
      notifier: tripStore,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: UserSelectionPage.routeName,
        routes: {
          UserSelectionPage.routeName: (_) => const UserSelectionPage(),
          SignInPage.routeName: (_) => const SignInPage(),
          RegisterPage.routeName: (_) => const RegisterPage(),
          ForgotPasswordPage.routeName: (_) => const ForgotPasswordPage(),
          DashboardPage.routeName: (_) => const DashboardPage(),
          CreateNewTripScreen.routeName: (_) => const CreateNewTripScreen(),
          TripSummaryScreen.routeName: (_) => const TripSummaryScreen(),
          ItineraryScreen.routeName: (_) => const ItineraryScreen(),
          DayMapScreen.routeName: (_) => const DayMapScreen(),
          SettingsScreen.routeName: (_) => const SettingsScreen(),
          EditProfileScreen.routeName: (_) => const EditProfileScreen(),
        },
      ),
    );
  }
}
