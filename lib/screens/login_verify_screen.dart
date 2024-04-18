import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mo_jannah/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginVerifyScreen extends StatelessWidget {
  const LoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        title: const Text('Vérification'),
        // back button
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: const Color.fromRGBO(14, 114, 85, 1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Entrez le code de vérification',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1.75,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nous vous avons envoyé un code de vérification sur votre numéro de téléphone',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 280,
                child: PinCodeTextField(
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 60,
                    activeFillColor: AppColors.primaryGreenDark,
                    inactiveFillColor: Colors.grey.shade200,
                    selectedFillColor: AppColors.primaryGreenDark,
                    inactiveColor: Colors.grey.shade200,
                    activeColor: AppColors.primaryGreenDark,
                    selectedColor: AppColors.primaryGreenDark,
                  ),
                  appContext: context,
                  length: 4,
                  onChanged: (value) {
                    print(value);
                  },
                  onCompleted: (value) {
                    // TODO: Verify the code and navigate to the next screen
                    context.go('/home');
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Vous n\'avez pas reçu le code?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    // TODO: Resend the code
                  },
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.green.shade50),
                  ),
                  child: const Text(
                    'Renvoyer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGreenDark,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
