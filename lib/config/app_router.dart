import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mo_jannah/screens/home_screen.dart';
import 'package:mo_jannah/screens/login_phone_screen.dart';
import 'package:mo_jannah/screens/login_screen.dart';
import 'package:mo_jannah/screens/login_verify_screen.dart';
import 'package:mo_jannah/screens/splash_screen.dart';

class GoRouterSetup {
  static final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: <GoRoute>[
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginScreen();
        },
        routes: <GoRoute>[
          GoRoute(
              path: 'phone',
              name: 'phone',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: LoginPhoneScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                );
              },
              routes: <GoRoute>[
                GoRoute(
                  path: 'verify',
                  name: 'verify',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const LoginVerifyScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ]),
        ],
      )
    ],
  );

  static GoRouter get router => _router;
}
