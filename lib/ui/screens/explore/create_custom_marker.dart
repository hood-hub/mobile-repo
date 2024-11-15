import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarker(String imageUrl, String username) async {
  final http.Response response = await http.get(Uri.parse(imageUrl));
  final Uint8List bytes = response.bodyBytes;

  // Create a picture recorder to draw our custom marker
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final double size = 200; // Total size of the marker
  final double circleSize = 100; // Size of the circle

  // Paint for white circle background
  final Paint circlePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  // Paint for circle border
  final Paint borderPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  // Calculate center position
  final double centerX = size / 2;
  final double centerY = circleSize / 2;

  // Draw white circle background
  canvas.drawCircle(
    Offset(centerX, centerY),
    circleSize / 2,
    circlePaint,
  );

  // Create circular clip for the image
  canvas.save();
  final Path clipPath = Path()
    ..addOval(Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: (circleSize / 2) - 3, // Slightly smaller to show border
    ));
  canvas.clipPath(clipPath);

  // Draw the profile image
  final ui.Codec codec = await ui.instantiateImageCodec(bytes,
    targetWidth: circleSize.toInt(),
    targetHeight: circleSize.toInt(),
  );
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final Rect rect = Rect.fromCircle(
    center: Offset(centerX, centerY),
    radius: circleSize / 2 - 3,
  );
  canvas.drawImageRect(
    frameInfo.image,
    Rect.fromLTWH(0, 0, frameInfo.image.width.toDouble(), frameInfo.image.height.toDouble()),
    rect,
    Paint(),
  );
  canvas.restore();

  // Draw purple border
  canvas.drawCircle(
    Offset(centerX, centerY),
    circleSize / 2,
    borderPaint,
  );

  // Draw username text
  final textPainter = TextPainter(
    text: TextSpan(
      text: username,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.white,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  textPainter.layout();

  // Draw white background for text
  final textBackgroundRect = RRect.fromRectAndRadius(
    Rect.fromCenter(
      center: Offset(centerX, centerY + circleSize/2 + 10),
      width: textPainter.width + 16,
      height: textPainter.height + 8,
    ),
    const Radius.circular(12),
  );
  canvas.drawRRect(textBackgroundRect, circlePaint);

  // Position and draw the text
  textPainter.paint(
    canvas,
    Offset(
      centerX - textPainter.width / 2,
      centerY + circleSize/2 + 6,
    ),
  );

  // Convert canvas to image
  final ui.Image image = await pictureRecorder.endRecording().toImage(
    size.toInt(),
    (size * 0.8).toInt(),
  );
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData == null) return BitmapDescriptor.defaultMarker;

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}