// Border styles: no border, thin, thick, colored.
// Shows SmoothRectangleBorder with different BorderSide configurations.
import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

import 'config.dart';

void main() {
  runGoldenTest(
    [
      scenario('no_border', Container(
        width: 100, height: 70,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(borderRadius: 12),
          color: Color(0xFFE3F2FD),
        ),
        alignment: Alignment.center,
        child: const Text('No border', style: TextStyle(fontSize: 11)),
      )),
      scenario('thin_border', Container(
        width: 100, height: 70,
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: 12,
            side: BorderSide(color: Colors.grey.shade400),
          ),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: const Text('Thin', style: TextStyle(fontSize: 11)),
      )),
      scenario('thick_border', Container(
        width: 100, height: 70,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: 12,
            side: BorderSide(color: Colors.blue, width: 3),
          ),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: const Text('Thick', style: TextStyle(fontSize: 11)),
      )),
      scenario('colored_border', Container(
        width: 100, height: 70,
        decoration: const ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: 12,
            side: BorderSide(color: Colors.red, width: 2),
          ),
          color: Color(0xFFFFF3E0),
        ),
        alignment: Alignment.center,
        child: const Text('Colored', style: TextStyle(fontSize: 11)),
      )),
    ],
    groupName: 'BORDER_STYLES',
    goldenName: 'Border styles: none, thin, thick, colored',
    fileName: 'golden_border_styles',
    columns: 4,
  );
}
