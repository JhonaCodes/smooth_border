import 'package:flutter/material.dart';
import 'package:smooth_border/smooth_border.dart';

void main() => runApp(const SmoothBorderExampleApp());

class SmoothBorderExampleApp extends StatelessWidget {
  const SmoothBorderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const SmoothBorderExamples(),
    );
  }
}

class SmoothBorderExamples extends StatelessWidget {
  const SmoothBorderExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('smooth_border')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Basic card ---
            _section('Basic Card'),
            Container(
              width: 220,
              height: 100,
              decoration: ShapeDecoration(
                shape: const SmoothRectangleBorder(borderRadius: 16),
                color: Colors.blue.shade50,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text('iOS-style Card'),
            ),
            const SizedBox(height: 24),

            // --- Bordered card ---
            _section('With Border'),
            Container(
              width: 220,
              height: 100,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: 16,
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Text('Bordered'),
            ),
            const SizedBox(height: 24),

            // --- Clipped container ---
            _section('ClipPath'),
            ClipPath(
              clipper: const SmoothRectangleClipper(borderRadius: 20),
              child: Container(
                width: 220,
                height: 100,
                color: Colors.deepPurple,
                alignment: Alignment.center,
                child: const Text('Clipped',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),

            // --- Card widget ---
            _section('Card(shape:)'),
            SizedBox(
              width: 220,
              child: Card(
                shape: const SmoothRectangleBorder(borderRadius: 16),
                elevation: 4,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Material Card'),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Comparison ---
            _section('Standard vs Smooth (radius 16)'),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.red.shade400,
                  ),
                  alignment: Alignment.center,
                  child: const Text('Standard',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const ShapeDecoration(
                    shape: SmoothRectangleBorder(borderRadius: 16),
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: const Text('Smooth',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Smoothing levels ---
            _section('Smoothing: 0.0 → 0.6 → 1.0'),
            Row(
              children: [
                for (final s in [0.0, 0.6, 1.0]) ...[
                  if (s > 0) const SizedBox(width: 12),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: 16,
                        smoothing: s,
                      ),
                      color: Colors.teal,
                    ),
                    alignment: Alignment.center,
                    child: Text('$s',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),

            // --- ElevatedButton ---
            _section('ElevatedButton'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const SmoothRectangleBorder(borderRadius: 12),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
              ),
              onPressed: () {},
              child: const Text('Smooth Button'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  );
}
