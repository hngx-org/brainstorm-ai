import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/presentation/screens/chat_automations/chat_automations.dart';
import 'package:ai_brainstorm/presentation/screens/home/home.dart';
import 'package:ai_brainstorm/presentation/screens/navigation/navigation.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/intro_screen/intro_screen.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/landing/landing_screen.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/signup/signup.dart';
import 'package:ai_brainstorm/presentation/screens/chat/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/settings/settings_screen.dart';
import 'package:ai_brainstorm/presentation/screens/splash_screen.dart';
import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';
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
                lastName: args['last_name'],
              ),
              key: state.pageKey,
            );
          } else {
            return CupertinoPage<void>(
              child: const NavigationScreen(
                firstName: '',
                lastName: '',
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
      pageBuilder: (context, state) {
        if (state.extra != null) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CupertinoPage<void>(
            child: ChatScreen(
              automated: args['automated'],
            ),
            key: state.pageKey,
          );
        }
        else {
          return CupertinoPage<void>(
            child: ChatScreen(
              automated: 0,
            ),
            key: state.pageKey,
          );
        }
      }
    ),
    GoRoute(
      path: RoutesPath.intro,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const IntroScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.mainSuscribeScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const MainSuscribeScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.mainAutomations,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const MainAutomations(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
    path: RoutesPath.settingsScreen,
    pageBuilder: (context, state) {
      if (state.extra != null) {
        Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return CupertinoPage<void>(
          child: SettingsScreen(
            firstname: args['firstname'], lastname: args['lastname'],
          ),
          key: state.pageKey,
        );
      }
      else {
        return CupertinoPage<void>(
          child: SettingsScreen(
            firstname: '', lastname: '',
          ),
          key: state.pageKey,
        );
      }
    },
  ),
  ],
);
