// Smoothing intensity levels at a fixed radius.
// Shows the visual difference between 0.0 (standard), 0.3, 0.6 (iOS), and 1.0.
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

void main() {
  runGoldenTest(
    [
      for (final s in [0.0, 0.3, 0.6, 1.0])
        scenario(
          'smoothing_${s.toString().replaceAll('.', '_')}',
          Container(
            width: 100,
            height: 80,
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(borderRadius: 20, smoothing: s),
              color: Colors.deepOrange,
            ),
            alignment: Alignment.center,
            child: Text('$s',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ),
    ],
    groupName: 'SMOOTHING_LEVELS',
    goldenName: 'Smoothing 0.0 → 0.3 → 0.6 → 1.0 at radius 20',
    fileName: 'golden_smoothing_levels',
    columns: 4,
  );
}
