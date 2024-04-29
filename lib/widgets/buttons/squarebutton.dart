import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class SquareButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget push;
  final bool requiresAuth;
  final bool enabled;
  const SquareButton({
    super.key,
    required this.title,
    required this.icon,
    required this.push,
    this.requiresAuth = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication auth = LocalAuthentication();
    bool dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: 120,
      height: 120,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: enabled
            ? () async {
                if (requiresAuth) {
                  try {
                    final bool didAuthenticate = await auth.authenticate(
                      options: const AuthenticationOptions(
                        biometricOnly: false,
                      ),
                      localizedReason:
                          'Please authenticate to open private notes.',
                    );
                    if (!didAuthenticate) {
                      return;
                    }
                  } on PlatformException catch (e) {
                    if ([
                      auth_error.lockedOut,
                      auth_error.permanentlyLockedOut,
                      auth_error.otherOperatingSystem,
                      auth_error.biometricOnlyNotSupported
                    ].contains(e.code)) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text(e.message ?? 'An error has occurred.'),
                          ),
                        );
                      }
                      return;
                    }
                  }
                }
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => push,
                    ),
                  );
                }
              }
            : null,
        child: Ink(
          decoration: BoxDecoration(
            color: dark
                ? Color.fromARGB(enabled ? 255 : 150, 58, 78, 126)
                : Color.fromARGB(enabled ? 255 : 150, 143, 166, 220),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: 30,
                      child: AutoSizeText(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                        minFontSize: 1,
                      )),
                ),
                icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
