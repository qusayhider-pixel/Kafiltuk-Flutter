import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/appointments/presentation/pages/appointments_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/doctor_booking/data/models/doctor_model.dart';
import '../../features/doctor_booking/presentation/pages/doctor_details_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../widgets/main_shell.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String appointments = '/appointments';
  static const String profile = '/profile';
  static const String details = '/details';

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: splash,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: signup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: details,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final doctor = state.extra as Doctor;
          return DoctorDetailsPage(doctor: doctor);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: appointments,
                builder: (context, state) => const AppointmentsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}