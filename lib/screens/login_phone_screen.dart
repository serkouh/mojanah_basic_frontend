import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mo_jannah/theme/app_colors.dart';

class LoginPhoneScreen extends StatefulWidget {
  LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  String phoneText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        title: const Text('Connexion'),
        // back button
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Color.fromRGBO(14, 114, 85, 1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Entrez votre numéro de téléphone',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1.75,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nous vous enverrons un code de vérification pour vérifier votre numéro de téléphone',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Votre numéro de téléphone',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primaryGreenDark,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                cursorColor: AppColors.primaryGreenDark,
                cursorWidth: 1.5,
                textAlignVertical: TextAlignVertical.bottom,
                initialCountryCode: 'MA',
                languageCode: 'fr',
                disableLengthCheck: true,
                autofocus: true,
                onChanged: (phone) {
                  setState(() {
                    phoneText = phone.completeNumber;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (validatePhone(phoneText)) {
                          context.go('/login/phone/verify');
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          validatePhone(phoneText)
                              ? AppColors.primaryGreenDark
                              : Colors.grey.shade400,
                        ),
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
                      child: const Text(
                        'Continuer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // phone validation
  bool validatePhone(String phone) {
    if (phone.isEmpty) {
      return false;
    } else if (phone.length < 14) {
      return false;
    }
    return true;
  }
}
