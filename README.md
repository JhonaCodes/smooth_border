# Smooth Border

[![Dart 3](https://img.shields.io/badge/Dart-3%2B-blue.svg)](https://dart.dev/)
[![Flutter 3.10](https://img.shields.io/badge/Flutter-3%2B-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

iOS-style continuous corner radius (squircle) for Flutter. Zero dependencies.

Unlike standard `BorderRadius.circular()` which uses circular arcs with an abrupt transition, `SmoothRectangleBorder` uses cubic bezier curves that create a smooth, gradual transition between the straight edge and the curve — matching the visual style of iOS and Figma rounded rectangles.

## Features

- **`SmoothRectangleBorder`** — a `ShapeBorder` that works with any Flutter widget
- **`SmoothRectangleClipper`** — a `CustomClipper<Path>` for `ClipPath`
- **Adjustable smoothing** — from `0.0` (standard circular) to `1.0` (maximum smoothness)
- **Zero dependencies** — pure Dart/Flutter, no external packages
- **All 4 corners symmetric** — works correctly with any aspect ratio

## Getting Started

```yaml
dependencies:
  smooth_border: ^1.0.3
```

```dart
import 'package:smooth_border/smooth_border.dart';
```

## Usage

### Container / ShapeDecoration

```dart
Container(
  decoration: ShapeDecoration(
    shape: SmoothRectangleBorder(borderRadius: 16),
    color: Colors.white,
    shadows: [
      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
    ],
  ),
  child: Text("iOS Card"),
)
```

### With border

```dart
Container(
  decoration: ShapeDecoration(
    shape: SmoothRectangleBorder(
      borderRadius: 16,
      side: BorderSide(color: Colors.grey.shade300),
    ),
    color: Colors.white,
  ),
)
```

### Card

```dart
Card(
  shape: SmoothRectangleBorder(borderRadius: 12),
  child: ListTile(title: Text("Smooth Card")),
)
```

### ClipPath (images, containers)

```dart
ClipPath(
  clipper: SmoothRectangleClipper(borderRadius: 20),
  child: Image.network("https://..."),
)
```

### ElevatedButton / OutlinedButton

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: SmoothRectangleBorder(borderRadius: 12),
  ),
  onPressed: () {},
  child: Text("Smooth Button"),
)
```

### Dialog

```dart
showDialog(
  context: context,
  builder: (_) => Dialog(
    shape: SmoothRectangleBorder(borderRadius: 20),
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Text("Smooth Dialog"),
    ),
  ),
);
```

### Smoothing levels

```dart
// Standard circular (no smoothing)
SmoothRectangleBorder(borderRadius: 16, smoothing: 0.0)

// iOS/Figma default (recommended)
SmoothRectangleBorder(borderRadius: 16, smoothing: 0.6)

// Maximum smoothness
SmoothRectangleBorder(borderRadius: 16, smoothing: 1.0)
```

## Golden Tests

Visual reference for each feature, generated from golden tests.

### Standard vs Smooth (radius 8)
Direct comparison showing the subtle difference at small radius. The smooth variant has a gradual shoulder transition instead of an abrupt circular arc.

![Comparison R8](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_comparison_r8.png)

### Standard vs Smooth (radius 16)
At medium radius the difference becomes clearly visible — the smooth corner starts curving earlier and has a wider, softer shoulder.

![Comparison R16](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_comparison_r16.png)

### Standard vs Smooth (radius 24)
At large radius the squircle shape is very pronounced compared to the standard circular arc.

![Comparison R24](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_comparison_r24.png)

### Radius Range (0–32)
How the smooth corner shape changes as radius increases from 0 (sharp) to 32 (pill-like).

![Radius Range](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_radius_range.png)

### Smoothing Levels (0.0 → 1.0)
The `smoothing` parameter at a fixed radius of 20. At 0.0 it matches standard `BorderRadius.circular()`. At 0.6 (iOS default) the shoulder is visible. At 1.0 the curve is maximally smooth.

![Smoothing Levels](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_smoothing_levels.png)

### Border Styles
`SmoothRectangleBorder` with different `BorderSide` configurations: no border, thin, thick (3px), and colored.

![Border Styles](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_border_styles.png)

### Aspect Ratios
Verifies all 4 corners stay symmetric regardless of shape: square, wide rectangle, tall rectangle, and small box.

![Shapes](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_shapes.png)

### ClipPath
`SmoothRectangleClipper` clipping containers at different radius and smoothing values.

![Clip](https://raw.githubusercontent.com/JhonaCodes/smooth_border/main/test/golden_test/goldens/macos/golden_clip.png)

## How it works

Each corner is drawn with 2 cubic bezier segments instead of a single circular arc. The control points are derived from `cos(45deg)` ratios, matching the algorithm used by Figma and iOS for continuous corner radius.

The `smoothing` parameter controls how far the curve extends beyond the circular arc region:

| smoothing | Effect |
|-----------|--------|
| `0.0` | Identical to `RoundedRectangleBorder` |
| `0.6` | iOS/Figma default — subtle but visible difference |
| `1.0` | Maximum smoothness — very pronounced shoulder |

## API Reference

### SmoothRectangleBorder

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `borderRadius` | `double` | `0` | Corner radius in logical pixels |
| `smoothing` | `double` | `0.6` | Smoothing intensity (0.0–1.0) |
| `side` | `BorderSide` | `BorderSide.none` | Border line style |

Implements `OutlinedBorder`, so it works everywhere `ShapeBorder` is accepted.

### SmoothRectangleClipper

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `borderRadius` | `double` | `0` | Corner radius in logical pixels |
| `smoothing` | `double` | `0.6` | Smoothing intensity (0.0–1.0) |

Implements `CustomClipper<Path>` for use with `ClipPath`.

## Contributing

Contributions are welcome! Open an issue or submit a pull request on [GitHub](https://github.com/JhonaCodes/smooth_border).

## License

MIT License. See [LICENSE](LICENSE) for details.
