# smooth_border

## 1.0.1

### Added
- **Golden tests** — 6 visual test suites with side-by-side comparisons:
  - Standard vs smooth corners at radius 8, 16, 24
  - Smooth radius range (0–32)
  - Smoothing intensity levels (0.0, 0.3, 0.6, 1.0)
  - Border styles (none, thin, thick, colored)
  - Aspect ratios (square, wide, tall, small)
  - ClipPath with SmoothRectangleClipper

## 1.0.0

### Initial Release

- **`SmoothRectangleBorder`** — iOS-style continuous corner radius as a `ShapeBorder`. Works with `Container`, `Card`, `Material`, `ElevatedButton`, `Dialog`, and any widget that accepts `ShapeBorder`.
- **`SmoothRectangleClipper`** — `CustomClipper<Path>` for `ClipPath` to clip any widget to a squircle shape.
- **`smoothPath()`** — core path generation function using cubic bezier curves derived from Figma's smooth corners algorithm.
- **Adjustable smoothing** — `0.0` (standard circular) to `1.0` (maximum smoothness). Default `0.6` matches iOS/Figma.
- **Symmetric corners** — all 4 corners are identical regardless of widget aspect ratio.
- **Zero dependencies** — pure Dart/Flutter implementation.
