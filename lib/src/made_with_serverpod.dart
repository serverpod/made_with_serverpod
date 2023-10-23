import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MadeWithServerpod extends StatelessWidget {
  const MadeWithServerpod({
    required this.child,
    this.url,
    super.key,
  });

  final Widget child;

  final Uri? url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff03132d),
                Color(0xff76517a),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                package: 'made_with_serverpod',
                width: 128,
                height: 35,
              ),
              const Spacer(),
              if (url != null)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white54,
                    ),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    launchUrl(url!);
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('View code'),
                      SizedBox(width: 4),
                      Icon(
                        Icons.description_outlined,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              if (url == null)
                const Text(
                  'Made with Serverpod',
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
