// Different aspect ratios and sizes.
// Verifies that all 4 corners are symmetric regardless of shape.
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

void main() {
  runGoldenTest(
    [
      scenario('square', Container(
        width: 80, height: 80,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(borderRadius: 16),
          color: Colors.green,
        ),
        alignment: Alignment.center,
        child: const Text('Square', style: TextStyle(color: Colors.white, fontSize: 11)),
      )),
      scenario('wide', Container(
        width: 180, height: 50,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(borderRadius: 16),
          color: Colors.orange,
        ),
        alignment: Alignment.center,
        child: const Text('Wide', style: TextStyle(color: Colors.white, fontSize: 11)),
      )),
      scenario('tall', Container(
        width: 60, height: 120,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(borderRadius: 16),
          color: Colors.purple,
        ),
        alignment: Alignment.center,
        child: const Text('Tall', style: TextStyle(color: Colors.white, fontSize: 11)),
      )),
      scenario('small', Container(
        width: 40, height: 40,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(borderRadius: 12),
          color: Colors.red,
        ),
        alignment: Alignment.center,
        child: const Text('S', style: TextStyle(color: Colors.white, fontSize: 11)),
      )),
    ],
    groupName: 'ASPECT_RATIOS',
    goldenName: 'Different aspect ratios with smooth corners',
    fileName: 'golden_shapes',
    columns: 2,
    fixedWidth: 220,
  );
}
