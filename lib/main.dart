import 'package:flutter/material.dart';
import 'package:mo_jannah/config/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mo Jannah',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: GoRouterSetup.router,
    );
  }
}
