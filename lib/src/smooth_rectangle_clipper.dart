import 'package:flutter/material.dart';

import 'smooth_path.dart';

/// A [CustomClipper] that clips to an iOS-style continuous rounded rectangle.
///
/// Use with [ClipPath] for clipping images, containers, or any widget
/// to a squircle shape.
///
/// ```dart
/// ClipPath(
///   clipper: SmoothRectangleClipper(borderRadius: 16),
///   child: Image.network('...'),
/// )
/// ```
class SmoothRectangleClipper extends CustomClipper<Path> {
  /// Corner radius in logical pixels.
  final double borderRadius;

  /// Smoothing intensity (0.0–1.0). Default `0.6` = iOS/Figma.
  final double smoothing;

  /// Creates a smooth rectangle clipper.
  const SmoothRectangleClipper({
    this.borderRadius = 0,
    this.smoothing = 0.6,
  });

  @override
  Path getClip(Size size) {
    return smoothPath(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderRadius,
      smoothing,
    );
  }

  @override
  bool shouldReclip(covariant SmoothRectangleClipper oldClipper) =>
      borderRadius != oldClipper.borderRadius ||
      smoothing != oldClipper.smoothing;
}
