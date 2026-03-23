import 'dart:math';
import 'dart:ui';

/// Generates an iOS-style continuous rounded rectangle [Path].
///
/// Each corner is drawn with 2 cubic bézier segments that create a
/// gradual, smooth transition between the straight edge and the curve.
///
/// The algorithm uses constants derived from `cos(45°)` to compute
/// the arc-to-line transition points, matching the Figma/iOS approach.
///
/// [smoothing] controls the intensity:
/// - `0.0` = identical to standard circular [RRect]
/// - `0.6` = iOS/Figma default
/// - `1.0` = maximum smoothness
Path smoothPath(Rect rect, double radius, double smoothing) {
  final r = radius.clamp(0.0, rect.shortestSide / 2);

  // Fall back to standard RRect when no smoothing or radius.
  if (r == 0 || smoothing == 0) {
    return Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)));
  }

  // How far from the corner the curve extends, clamped uniformly
  // so all 4 corners are identical regardless of rect aspect ratio.
  final maxP = rect.shortestSide / 2;
  final p = min((1 + smoothing) * r, maxP);

  // Effective radius recomputed from clamped p so all bézier
  // control points stay proportional and symmetric.
  final er = p / (1 + smoothing);

  // Arc-to-line transition ratios (derived from Figma's algorithm).
  final a = er * 0.292893; // er * (1 - cos(45°))
  final b = er * 0.585786; // er * (1 - cos(45°)) * 2
  final d = (p - er) * smoothing; // smoothing extension

  final l = rect.left;
  final t = rect.top;
  final ri = rect.right;
  final bo = rect.bottom;

  return Path()
    ..moveTo(l + p, t)
    // Top edge → Top-right corner
    ..lineTo(ri - p, t)
    ..cubicTo(ri - p + d, t, ri - b, t, ri - a, t + a)
    ..cubicTo(ri, t + b, ri, t + p - d, ri, t + p)
    // Right edge → Bottom-right corner
    ..lineTo(ri, bo - p)
    ..cubicTo(ri, bo - p + d, ri, bo - b, ri - a, bo - a)
    ..cubicTo(ri - b, bo, ri - p + d, bo, ri - p, bo)
    // Bottom edge → Bottom-left corner
    ..lineTo(l + p, bo)
    ..cubicTo(l + p - d, bo, l + b, bo, l + a, bo - a)
    ..cubicTo(l, bo - b, l, bo - p + d, l, bo - p)
    // Left edge → Top-left corner
    ..lineTo(l, t + p)
    ..cubicTo(l, t + p - d, l, t + b, l + a, t + a)
    ..cubicTo(l + b, t, l + p - d, t, l + p, t)
    ..close();
}
