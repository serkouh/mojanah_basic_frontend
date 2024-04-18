import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // wait for 2 seconds then navigate to login screen
    Future.delayed(const Duration(seconds: 2), () {
      context.go('/login');
    });
  }

  @override
  void dispose() {
    // show the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(5, 242, 175, 1),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logos/splash-logo.png'),
                width: 250,
                height: 250,
              ),
              SizedBox(
                height: 20,
              ),
              SpinKitRing(
                color: Color.fromRGBO(14, 114, 85, 1),
                size: 50.0,
                lineWidth: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
