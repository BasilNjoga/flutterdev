import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email address')),
      body: Column(children: [
            const Text("we've sent to you an email verification. please open it to verify your account."),
            const Text("If you haven't received a verification email please click below"),
            TextButton(onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            }, child: const Text("Send email verificaton") ,),
            TextButton(onPressed: () async {
              await AuthService.firebase().logOut();
              
              Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false);
            }, child: const Text("Restart"))
          ],
          ),
    );
  }
}