import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

const _textOffset = 30.0;

const _packageName = 'made_with_serverpod';

const _assetLogoTextBlack = 'assets/logo-text-black.svg';
const _assetLogoTextWhite = 'assets/logo-text-white.svg';
const _assetLogoLottie = 'assets/serverpod-logo.json';

class AnimatedServerpodLogo extends StatefulWidget {
  const AnimatedServerpodLogo({
    super.key,
    this.loop = true,
    this.brightness = Brightness.light,
    this.animate = true,
  });

  final bool loop;
  final Brightness brightness;
  final bool animate;

  @override
  State<AnimatedServerpodLogo> createState() => _AnimatedServerpodLogoState();

  static Future<void> precache() async {
    var assetLottie = AssetLottie(
      _assetLogoLottie,
      package: _packageName,
    );

    const svgBlackLogoLoader = SvgAssetLoader(
      _assetLogoTextBlack,
      packageName: _packageName,
    );
    const svgWhiteLogoLoader = SvgAssetLoader(
      _assetLogoTextWhite,
      packageName: _packageName,
    );
    Future.wait([
      assetLottie.load(),
      svg.cache.putIfAbsent(
        svgBlackLogoLoader.cacheKey(null),
        () => svgBlackLogoLoader.loadBytes(null),
      ),
      svg.cache.putIfAbsent(
        svgWhiteLogoLoader.cacheKey(null),
        () => svgWhiteLogoLoader.loadBytes(null),
      ),
    ]);
  }
}

class _AnimatedServerpodLogoState extends State<AnimatedServerpodLogo>
    with TickerProviderStateMixin {
  late final _lottieController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

  late final _textPositionController = AnimationController(
    duration: const Duration(seconds: 1, milliseconds: 500),
    vsync: this,
  );

  late final _textOpacityController = AnimationController(
    duration: const Duration(seconds: 1, microseconds: 500),
    vsync: this,
  );

  late final _deconstructController = AnimationController(
    duration: const Duration(seconds: 1),
    value: 1.0,
    vsync: this,
  );

  Timer? _textTimer;
  Timer? _deconstructTimer;
  Timer? _loopTimer;

  @override
  void initState() {
    super.initState();

    _lottieController.addListener(_animationUpdated);
    _textPositionController.addListener(_animationUpdated);
    _textOpacityController.addListener(_animationUpdated);
    _deconstructController.addListener(_animationUpdated);

    _startAnimation();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _textPositionController.dispose();
    _textOpacityController.dispose();
    _deconstructController.dispose();

    _textTimer?.cancel();
    _deconstructTimer?.cancel();
    _loopTimer?.cancel();

    super.dispose();
  }

  void _startAnimation() {
    if (!widget.animate) {
      _stopAnimation();

      return;
    }
    _textTimer?.cancel();
    _deconstructTimer?.cancel();
    _loopTimer?.cancel();

    _lottieController.reset();
    _textPositionController.reset();
    _textOpacityController.reset();
    _deconstructController.value = 1.0;

    _lottieController.forward();

    _textTimer = Timer(const Duration(seconds: 1, microseconds: 500), () {
      _textPositionController.animateTo(1.0, curve: Curves.easeOut);
      _textOpacityController.animateTo(1.0);
    });

    if (widget.loop) {
      _deconstructTimer = Timer(const Duration(seconds: 8), () {
        _deconstructController.animateTo(0.0);
      });

      _loopTimer = Timer(const Duration(seconds: 9), () {
        _startAnimation();
      });
    }
  }

  void _stopAnimation() {
    _lottieController.value = 1.0;
    _textOpacityController.value = 1.0;
    _textPositionController.value = 1.0;

    _textTimer?.cancel();
    _deconstructTimer?.cancel();
    _loopTimer?.cancel();
  }

  void _animationUpdated() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AnimatedServerpodLogo oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animate != widget.animate || oldWidget.loop != widget.loop) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: 444,
        height: 421,
        child: Opacity(
          opacity: _deconstructController.value,
          child: Stack(
            children: [
              Opacity(
                opacity: _textOpacityController.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    _textOffset - _textPositionController.value * _textOffset,
                  ),
                  child: Transform.scale(
                    scale: 0.8 + 0.2 * _textPositionController.value,
                    child: SvgPicture.asset(
                      widget.brightness == Brightness.light
                          ? _assetLogoTextBlack
                          : _assetLogoTextWhite,
                      package: _packageName,
                      width: 444,
                      height: 421,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8.0,
                right: 8.0,
                bottom: 42.0,
                child: LottieBuilder.asset(
                  _assetLogoLottie,
                  package: _packageName,
                  controller: _lottieController,
                  // repeat: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
