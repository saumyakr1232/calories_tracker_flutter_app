import 'package:flutter/material.dart';

/// A customizable social sign-in button widget
class SocialSignInButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(text),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
    );
  }
}

/// Google sign-in button
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SocialSignInButton(
      text: 'Continue with Google',
      icon: Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
        height: 24,
      ),
      onPressed: onPressed,
    );
  }
}

/// Apple sign-in button
class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SocialSignInButton(
      text: 'Continue with Apple',
      icon: const Icon(Icons.apple),
      onPressed: onPressed,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
