import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/presentation/screens/home/home.dart';
import 'package:ai_brainstorm/presentation/screens/navigation.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/landing/landing_screen.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/signup/signup.dart';
import 'package:ai_brainstorm/presentation/screens/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutesPath.splash,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    GoRoute(
      path: RoutesPath.splash,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.landing,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const LandingScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.signup,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SignUpScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
        path: RoutesPath.nav,
        pageBuilder: (context, state) {
          if (state.extra != null) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return CupertinoPage<void>(
              child: NavigationScreen(
                firstName: args['first_name'],
              ),
              key: state.pageKey,
            );
          } else {
            return CupertinoPage<void>(
              child: const NavigationScreen(
                firstName: '',
              ),
              key: state.pageKey,
            );
          }
        }),
    GoRoute(
        path: RoutesPath.home,
        pageBuilder: (context, state) {
          if (state.extra != null) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return CupertinoPage<void>(
              child: HomeScreen(
                firstName: args['first_name'],
              ),
              key: state.pageKey,
            );
          } else {
            return CupertinoPage<void>(
              child: const HomeScreen(
                firstName: '',
              ),
              key: state.pageKey,
            );
          }
        }),
    GoRoute(
      path: RoutesPath.chatScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const ChatScreen(),
        key: state.pageKey,
      ),
    ),
  ],
);
