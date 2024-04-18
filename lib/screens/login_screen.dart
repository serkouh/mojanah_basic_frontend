import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mo_jannah/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1554672408-730436b60dde?q=80&w=1452&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),
        // bottom buttons for login
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // login with phone number
                  loginByPhoneBtn(onPressed: () {
                    context.go('/login/phone');
                  }),
                  const SizedBox(height: 16),
                  // login with google
                  loginWithGoogleBtn()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginWithGoogleBtn() {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // TODO: login with google
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.grey.shade800,
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.grey.shade100,
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        // icon & text
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icons/google-icon.svg',
              height: 24, // adjust size as needed
              width: 24,
              // asset name
            ),
            const SizedBox(width: 8),
            const Text('Continue with Google'),
          ],
        ),
      ),
    );
  }

  Widget loginByPhoneBtn({required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          backgroundColor:
              MaterialStateProperty.all(AppColors.primaryGreenDark),
          foregroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        child: const Text('Continue with phone number'),
      ),
    );
  }
}
