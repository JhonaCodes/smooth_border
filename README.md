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
  smooth_border: ^1.0.0
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
