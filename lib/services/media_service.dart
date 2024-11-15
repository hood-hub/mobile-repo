import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  /// Pick multiple images and videos
  Future<List<File>> pickMultipleMedia() async {
    try {
      // Pick multiple images and videos
      final List<XFile> medias = await _picker.pickMultipleMedia();

      // Convert the selected XFile instances to File instances
      return medias.map((media) => File(media.path)).toList();
    } catch (e) {
      throw Exception('Failed to pick media: $e');
    }
  }
}
