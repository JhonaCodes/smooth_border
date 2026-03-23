# smooth_border

## 1.0.0

### Initial Release

- **`SmoothRectangleBorder`** — iOS-style continuous corner radius as a `ShapeBorder`. Works with `Container`, `Card`, `Material`, `ElevatedButton`, `Dialog`, and any widget that accepts `ShapeBorder`.
- **`SmoothRectangleClipper`** — `CustomClipper<Path>` for `ClipPath` to clip any widget to a squircle shape.
- **`smoothPath()`** — core path generation function using cubic bezier curves derived from Figma's smooth corners algorithm.
- **Adjustable smoothing** — `0.0` (standard circular) to `1.0` (maximum smoothness). Default `0.6` matches iOS/Figma.
- **Symmetric corners** — all 4 corners are identical regardless of widget aspect ratio.
- **Zero dependencies** — pure Dart/Flutter implementation.
