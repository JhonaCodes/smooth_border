import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_border/smooth_border.dart';

void main() {
  // --- SmoothRectangleBorder ---

  group('SmoothRectangleBorder', () {
    test('getOuterPath returns closed path', () {
      const border = SmoothRectangleBorder(borderRadius: 12);
      final path = border.getOuterPath(const Rect.fromLTWH(0, 0, 100, 50));
      expect(path.getBounds().width, greaterThan(0));
      expect(path.getBounds().height, greaterThan(0));
    });

    test('getInnerPath deflates by side width', () {
      const border = SmoothRectangleBorder(
        borderRadius: 12,
        side: BorderSide(width: 2),
      );
      final outer = border.getOuterPath(const Rect.fromLTWH(0, 0, 100, 50));
      final inner = border.getInnerPath(const Rect.fromLTWH(0, 0, 100, 50));
      expect(inner.getBounds().width, lessThan(outer.getBounds().width));
    });

    test('smoothing 0 produces standard RRect', () {
      const border = SmoothRectangleBorder(
        borderRadius: 12,
        smoothing: 0,
      );
      final path = border.getOuterPath(const Rect.fromLTWH(0, 0, 100, 50));
      // Standard RRect path should have specific bounds
      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 50));
    });

    test('radius 0 produces standard rectangle', () {
      const border = SmoothRectangleBorder(borderRadius: 0);
      final path = border.getOuterPath(const Rect.fromLTWH(0, 0, 100, 50));
      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 50));
    });

    test('scale multiplies radius and side', () {
      const border = SmoothRectangleBorder(
        borderRadius: 10,
        side: BorderSide(width: 2),
      );
      final scaled = border.scale(2) as SmoothRectangleBorder;
      expect(scaled.borderRadius, 20);
      expect(scaled.side.width, 4);
      expect(scaled.smoothing, border.smoothing);
    });

    test('copyWith preserves values', () {
      const border = SmoothRectangleBorder(
        borderRadius: 16,
        smoothing: 0.8,
        side: BorderSide(color: Colors.red),
      );
      final copied = border.copyWith(
        side: const BorderSide(color: Colors.blue),
      );
      expect(copied.side.color, Colors.blue);
      expect((copied as SmoothRectangleBorder).borderRadius, 16);
      expect(copied.smoothing, 0.8);
    });

    test('equality and hashCode', () {
      const a = SmoothRectangleBorder(borderRadius: 12, smoothing: 0.6);
      const b = SmoothRectangleBorder(borderRadius: 12, smoothing: 0.6);
      const c = SmoothRectangleBorder(borderRadius: 16, smoothing: 0.6);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(equals(c)));
    });

    test('toString is descriptive', () {
      const border = SmoothRectangleBorder(borderRadius: 12);
      expect(border.toString(), contains('SmoothRectangleBorder'));
      expect(border.toString(), contains('12'));
    });
  });

  // --- SmoothRectangleClipper ---

  group('SmoothRectangleClipper', () {
    test('getClip returns path matching size', () {
      const clipper = SmoothRectangleClipper(borderRadius: 12);
      final path = clipper.getClip(const Size(200, 100));
      final bounds = path.getBounds();
      expect(bounds.width, closeTo(200, 1));
      expect(bounds.height, closeTo(100, 1));
    });

    test('shouldReclip when radius changes', () {
      const a = SmoothRectangleClipper(borderRadius: 12);
      const b = SmoothRectangleClipper(borderRadius: 16);
      const c = SmoothRectangleClipper(borderRadius: 12);
      expect(a.shouldReclip(b), isTrue);
      expect(a.shouldReclip(c), isFalse);
    });

    test('shouldReclip when smoothing changes', () {
      const a = SmoothRectangleClipper(borderRadius: 12, smoothing: 0.6);
      const b = SmoothRectangleClipper(borderRadius: 12, smoothing: 0.8);
      expect(a.shouldReclip(b), isTrue);
    });
  });

  // --- Widget integration ---

  group('Widget integration', () {
    testWidgets('works with ShapeDecoration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            decoration: const ShapeDecoration(
              shape: SmoothRectangleBorder(borderRadius: 16),
              color: Colors.blue,
            ),
            width: 100,
            height: 100,
          ),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('works with ClipPath', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ClipPath(
            clipper: const SmoothRectangleClipper(borderRadius: 16),
            child: Container(width: 100, height: 100, color: Colors.red),
          ),
        ),
      );
      expect(find.byType(ClipPath), findsOneWidget);
    });

    testWidgets('works with Card shape', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Card(
            shape: SmoothRectangleBorder(borderRadius: 12),
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
