import 'package:flutter/material.dart';
import 'app_animation_durations.dart';

class AppAnimations {
  static Widget fadeIn({required Widget child, required bool visible}) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: AppAnimationDurations.normal,
      curve: Curves.easeInOut,
      child: child,
    );
  }

  static Widget scaleIn({required Widget child, required bool visible}) {
    return AnimatedScale(
      scale: visible ? 1.0 : 0.8,
      duration: AppAnimationDurations.normal,
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
