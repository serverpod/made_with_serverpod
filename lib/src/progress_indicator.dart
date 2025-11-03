import 'package:flutter/material.dart';

class ServerpodProgressIndicator extends StatelessWidget {
  const ServerpodProgressIndicator({super.key, this.size = 100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/nova-running.webp',
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            child: child,
          );
        },
        package: 'made_with_serverpod',
        width: size,
        height: size,
      ),
    );
  }
}
