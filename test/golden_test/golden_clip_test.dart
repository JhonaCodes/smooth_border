// SmoothRectangleClipper with ClipPath.
// Verifies clipping works correctly on colored containers.
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

void main() {
  runGoldenTest(
    [
      scenario('clip_r12', ClipPath(
        clipper: const SmoothRectangleClipper(borderRadius: 12),
        child: Container(width: 120, height: 80, color: Colors.teal,
          alignment: Alignment.center,
          child: const Text('Clip R12', style: TextStyle(color: Colors.white, fontSize: 11)),
        ),
      )),
      scenario('clip_r24', ClipPath(
        clipper: const SmoothRectangleClipper(borderRadius: 24),
        child: Container(width: 120, height: 80, color: Colors.deepPurple,
          alignment: Alignment.center,
          child: const Text('Clip R24', style: TextStyle(color: Colors.white, fontSize: 11)),
        ),
      )),
      scenario('clip_max_smooth', ClipPath(
        clipper: const SmoothRectangleClipper(borderRadius: 20, smoothing: 1.0),
        child: Container(width: 120, height: 80, color: Colors.pink,
          alignment: Alignment.center,
          child: const Text('Max Smooth', style: TextStyle(color: Colors.white, fontSize: 11)),
        ),
      )),
    ],
    groupName: 'CLIP_PATH',
    goldenName: 'SmoothRectangleClipper with ClipPath',
    fileName: 'golden_clip',
    columns: 3,
  );
}
