import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class CharacterWindow extends StatefulWidget {
  const CharacterWindow({super.key});

  @override
  State<CharacterWindow> createState() => _CharacterWindowState();
}

class _CharacterWindowState extends State<CharacterWindow>
    with SingleTickerProviderStateMixin {
  late final robotPositionHorizontal = AnimationController(
    vsync: this,
    debugLabel: 'robot position horizontal',
    // duration: Dur,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          foregroundPainter: RobotPainter(),
          size: const Size.fromHeight(96),
          painter: WindowPainter(),
        ),
        Positioned(
          top: -14,
          right: -14,
          child: NesIcon(
            iconData: NesIcons.moon,
            secondaryColor: Colors.amber,
          ),
        ),
      ],
    );
  }
}

class WindowPainter extends CustomPainter {
  WindowPainter({super.repaint});
  final pixelSize = 4;
  final backgroundPaint = Paint()..color = Colors.white;
  final shadowPaint = Paint()..color = Colors.amber.shade200;
  final borderPaint = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    // Top border
    canvas
      ..drawRect(
        Rect.fromLTWH(
          pixelSize.toDouble(),
          0,
          size.width - pixelSize * 2,
          pixelSize.toDouble(),
        ),
        borderPaint,
      )
      // Bottom border
      ..drawRect(
        Rect.fromLTWH(
          pixelSize.toDouble(),
          size.height - pixelSize,
          size.width - pixelSize * 2,
          pixelSize.toDouble(),
        ),
        borderPaint,
      )
      // Left border
      ..drawRect(
        Rect.fromLTWH(
          0,
          pixelSize.toDouble(),
          pixelSize.toDouble(),
          size.height - pixelSize * 2,
        ),
        borderPaint,
      )
      // Right border
      ..drawRect(
        Rect.fromLTWH(
          size.width - pixelSize,
          pixelSize.toDouble(),
          pixelSize.toDouble(),
          size.height - pixelSize * 2,
        ),
        borderPaint,
      )
      // Background
      ..drawRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ).deflate(
          pixelSize.toDouble(),
        ),
        backgroundPaint,
      )
      // draw bottom shadow
      ..drawRect(
        Rect.fromLTWH(
          pixelSize.toDouble(),
          size.height - pixelSize * 2,
          size.width - pixelSize * 2,
          pixelSize.toDouble(),
        ),
        shadowPaint,
      )
      // draw right shadow
      ..drawRect(
        Rect.fromLTWH(
          size.width - pixelSize * 2,
          pixelSize.toDouble(),
          pixelSize.toDouble(),
          size.height - pixelSize * 2,
        ),
        shadowPaint,
      );
  }

  @override
  bool shouldRepaint(covariant WindowPainter oldDelegate) => true;
}

extension ColorExtension on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1, 'Value must be between 0 and 1');

    final f = 1 - amount;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }
}

class RobotPainter extends CustomPainter {
  final pixelSize = 4;
  final pixelSizeDbl = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    const pixelMap = <List<int>>[
      [0, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 3, 1, 1, 1, 3, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 1, 1, 0, 0, 0, 1, 1, 0],
      [0, 1, 1, 0, 0, 0, 1, 1, 0],
    ];

    // Define colors for the pixels
    final colorMap = <int, Color>{
      0: Colors.transparent,
      1: Colors.grey,
      3: Colors.blue,
    };

    final paint = Paint()..strokeWidth = pixelSizeDbl;

    for (var y = 0; y < pixelMap.length; y++) {
      for (var x = 0; x < pixelMap[y].length; x++) {
        final color = colorMap[pixelMap[y][x]];
        if (color != Colors.transparent && color != null) {
          paint.color = color;

          final dy = (y * pixelSizeDbl) -
              (pixelSize * 2) +
              ((pixelSize * pixelMap.length) - size.height / pixelSize);
          final dx = (x * pixelSizeDbl) + 10;
          canvas.drawRect(
            Rect.fromLTWH(
              dx,
              dy,
              pixelSizeDbl + 0.35,
              pixelSizeDbl + 0.35,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
