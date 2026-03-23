import 'package:flutter/material.dart';

import 'smooth_path.dart';

/// A [ShapeBorder] with iOS-style continuous corner radius (squircle).
///
/// Unlike [RoundedRectangleBorder] which uses circular arcs with an abrupt
/// transition, this border uses cubic bézier curves that create a smooth,
/// gradual transition between the straight edge and the curve — matching
/// the visual style of iOS and Figma rounded rectangles.
///
/// Works with any widget that accepts [ShapeBorder]:
/// - [Container] via [ShapeDecoration]
/// - [Card] via `shape` parameter
/// - [Material] via `shape` parameter
/// - [ElevatedButton], [OutlinedButton] via `shape` in [ButtonStyle]
/// - [Dialog] via `shape` parameter
/// - [ClipPath] via [ShapeBorderClipper]
///
/// ```dart
/// Container(
///   decoration: ShapeDecoration(
///     shape: SmoothRectangleBorder(
///       borderRadius: 16,
///       smoothing: 0.6,
///       side: BorderSide(color: Colors.grey),
///     ),
///     color: Colors.white,
///   ),
///   child: Text("iOS Card"),
/// )
/// ```
class SmoothRectangleBorder extends OutlinedBorder {
  /// Corner radius in logical pixels.
  final double borderRadius;

  /// Smoothing intensity (0.0–1.0).
  ///
  /// - `0.0` = standard circular arc (identical to [RoundedRectangleBorder])
  /// - `0.6` = iOS/Figma default (recommended)
  /// - `1.0` = maximum smoothness
  final double smoothing;

  /// Creates a smooth rectangle border with continuous corners.
  ///
  /// [borderRadius] controls how round the corners are.
  /// [smoothing] controls how smooth the transition is (0.6 = iOS default).
  /// [side] defines the border line style.
  const SmoothRectangleBorder({
    this.borderRadius = 0,
    this.smoothing = 0.6,
    super.side,
  });

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return smoothPath(rect.deflate(side.width), borderRadius, smoothing);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return smoothPath(rect, borderRadius, smoothing);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0) return;

    final paint = side.toPaint();
    final path = smoothPath(
      rect.deflate(side.width / 2),
      borderRadius,
      smoothing,
    );
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) => SmoothRectangleBorder(
    borderRadius: borderRadius * t,
    smoothing: smoothing,
    side: side.scale(t),
  );

  @override
  OutlinedBorder copyWith({BorderSide? side}) => SmoothRectangleBorder(
    borderRadius: borderRadius,
    smoothing: smoothing,
    side: side ?? this.side,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmoothRectangleBorder &&
          borderRadius == other.borderRadius &&
          smoothing == other.smoothing &&
          side == other.side;

  @override
  int get hashCode => Object.hash(borderRadius, smoothing, side);

  @override
  String toString() =>
      'SmoothRectangleBorder(borderRadius: $borderRadius, smoothing: $smoothing, side: $side)';
}
