import 'package:flutter/material.dart';
import 'dart:math';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: CustomPaint(
//           size: const Size(56, 56),
//           painter: LinePieChartPainter(
//             percentages: [0.8], // 백분율 값 (0.0 ~ 1.0)
//             colors: [Colors.blue], // 각 섹션의 색상
//             lineWidth: 3, // 선의 두께
//           ),
//         ),
//       ),
//     );
//   }
// }

class LinePieChartPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;
  double? lineWidth;
  TextStyle? textStyle;

  LinePieChartPainter({
    required this.percentages,
    required this.colors,
    this.lineWidth,
    this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    Color firstColor = colors[0];

    // 배경을 흰색으로 그리는 부분 추가
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.75)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    // 배경 위에 불투명한 파란색을 그리는 부분 추가
    final foregroundPaint = Paint()
      ..color = firstColor.withOpacity(0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, foregroundPaint);

    double startAngle = -pi / 2; // 시작 각도: 12시 방향

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = 2 * pi * percentages[i];

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth ?? 3;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

      // 다음 섹션을 위해 시작 각도 업데이트
      startAngle += sweepAngle;
    }

    // 현재 숫자를 표시하는 텍스트 추가

    final chartTextStyle = textStyle != null
        ? textStyle
        : TextStyle(
            color: firstColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          );

    final textPainter = TextPainter(
      text: TextSpan(
          text: '${(percentages[0] * 100).toInt()}', style: chartTextStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final textCenter = Offset(
        center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
