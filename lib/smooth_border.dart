/// iOS-style continuous corner radius (squircle) for Flutter.
///
/// Provides [SmoothRectangleBorder], a [ShapeBorder] that creates
/// smooth, continuous corners matching the visual style of iOS and Figma.
///
/// Works with any widget that accepts [ShapeBorder]:
/// ```dart
/// Container(
///   decoration: ShapeDecoration(
///     shape: SmoothRectangleBorder(borderRadius: 16),
///     color: Colors.white,
///   ),
/// )
/// ```
library smooth_border;

export 'src/smooth_rectangle_border.dart';
export 'src/smooth_rectangle_clipper.dart';
