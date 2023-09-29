import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/presentation/screens/chat_screen.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/landing_screen/landing_screen.dart';
import 'package:ai_brainstorm/presentation/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';


final GoRouter routerConfig = GoRouter(
  initialLocation: RoutesPath.splashScreen,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    GoRoute(
      path: RoutesPath.splashScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.landingScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const LandingScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: RoutesPath.chatScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const ChatScreen(),
        key: state.pageKey,
      ),
    ),
  ],
);
