// Smooth corners at increasing radius values.
// Shows how the squircle curve changes from subtle (4) to pill-like (32).
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

void main() {
  runGoldenTest(
    [
      for (final r in [0.0, 4.0, 8.0, 12.0, 16.0, 24.0, 32.0])
        scenario(
          'smooth_r${r.toInt()}',
          Container(
            width: 100,
            height: 70,
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(borderRadius: r),
              color: Colors.teal,
            ),
            alignment: Alignment.center,
            child: Text('R${r.toInt()}',
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
    ],
    groupName: 'RADIUS_RANGE',
    goldenName: 'Smooth corners at increasing radius (0–32)',
    fileName: 'golden_radius_range',
    columns: 4,
  );
}
