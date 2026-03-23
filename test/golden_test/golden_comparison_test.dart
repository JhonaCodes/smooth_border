// Standard circular vs smooth corners — side by side comparison.
// Each radius is shown as standard (left) and smooth (right) so
// the difference in corner transition is clearly visible.
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

Widget _box(double radius, Color color, String label, {bool smooth = false}) {
  return Container(
    width: 100,
    height: 80,
    decoration: smooth
        ? ShapeDecoration(
            shape: SmoothRectangleBorder(borderRadius: radius),
            color: color,
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
    alignment: Alignment.center,
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
  );
}

void main() {
  // --- Radius 8: standard vs smooth ---
  runGoldenTest(
    [
      scenario('standard_r8', _box(8, Colors.blue, 'Standard R8')),
      scenario('smooth_r8', _box(8, Colors.blue, 'Smooth R8', smooth: true)),
    ],
    groupName: 'COMPARISON_R8',
    goldenName: 'Standard vs Smooth at radius 8',
    fileName: 'golden_comparison_r8',
    columns: 2,
  );

  // --- Radius 16: standard vs smooth ---
  runGoldenTest(
    [
      scenario('standard_r16', _box(16, Colors.indigo, 'Standard R16')),
      scenario('smooth_r16', _box(16, Colors.indigo, 'Smooth R16', smooth: true)),
    ],
    groupName: 'COMPARISON_R16',
    goldenName: 'Standard vs Smooth at radius 16',
    fileName: 'golden_comparison_r16',
    columns: 2,
  );

  // --- Radius 24: standard vs smooth ---
  runGoldenTest(
    [
      scenario('standard_r24', _box(24, Colors.deepPurple, 'Standard R24')),
      scenario('smooth_r24', _box(24, Colors.deepPurple, 'Smooth R24', smooth: true)),
    ],
    groupName: 'COMPARISON_R24',
    goldenName: 'Standard vs Smooth at radius 24',
    fileName: 'golden_comparison_r24',
    columns: 2,
  );
}
