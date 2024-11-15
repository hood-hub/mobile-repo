import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

// MediaType enum to handle different media types
enum MediaType { image, video, unknown }



// Media model with thumbnail support
class Media {
  final String url;
  final MediaType type;
  String? thumbnailPath;

  Media({
    required this.url,
    required this.type,
    this.thumbnailPath,
  });

  factory Media.fromUrl(String url) {
    final extension = url.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Media(url: url, type: MediaType.image);
      case 'mp4':
      case 'mov':
      case 'avi':
        return Media(url: url, type: MediaType.video);
      default:
        return Media(url: url, type: MediaType.unknown);
    }
  }

  Future<void> generateThumbnail() async {
    if (type == MediaType.video && thumbnailPath == null) {
      try {
        final tempDir = await getTemporaryDirectory();
        final fileName = 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final thumbnailFile = await VideoThumbnail.thumbnailFile(
          video: url,
          thumbnailPath: '${tempDir.path}/$fileName',
          imageFormat: ImageFormat.JPEG,
          maxHeight: 300,
          quality: 75,
        );

        if (thumbnailFile != null) {
          thumbnailPath = thumbnailFile.path;
        }
      } catch (e) {
        print('Error generating thumbnail: $e');
        // Fallback to a frame grab if thumbnail generation fails
        try {
          final bytes = await VideoThumbnail.thumbnailData(
            video: url,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 300,
            quality: 75,
          );

          if (bytes != null) {
            final tempDir = await getTemporaryDirectory();
            final fileName = 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
            final file = File('${tempDir.path}/$fileName');
            await file.writeAsBytes(bytes);
            thumbnailPath = file.path;
          }
        } catch (e) {
          print('Error generating thumbnail data: $e');
        }
      }
    }
  }
}

class MediaGridWidget extends StatefulWidget {
  final List<String> mediaUrls;

  const MediaGridWidget({
    Key? key,
    required this.mediaUrls,
  }) : super(key: key);

  @override
  State<MediaGridWidget> createState() => _MediaGridWidgetState();
}

class _MediaGridWidgetState extends State<MediaGridWidget> {
  late List<Media> _mediaList;
  bool _loadingThumbnails = true;

  @override
  void initState() {
    super.initState();
    _mediaList = widget.mediaUrls.map((url) => Media.fromUrl(url)).toList();
    //_generateThumbnails();
  }

  Future<void> _generateThumbnails() async {
    try {
      await Future.wait(
        _mediaList.map((media) => media.generateThumbnail()),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loadingThumbnails = false;
        });
      }
    }
  }

  Widget _buildMediaTile(Media media) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaViewerPage(media: media),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (media.type == MediaType.video)
              if (media.url != null)
                Image.file(
                  File(media.url!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.video_library),
                    );
                  },
                )
              else if (_loadingThumbnails)
                const Center(child: CircularProgressIndicator())
              else
                Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.video_library),
                )
            else
              Image.network(
                media.url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  );
                },
              ),
            if (media.type == MediaType.video)
              const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 48,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_mediaList.isEmpty) return const SizedBox.shrink();

    if (_mediaList.length == 1) {
      return AspectRatio(
        aspectRatio: 1.5,
        child: _buildMediaTile(_mediaList[0]),
      );
    }

    if (_mediaList.length == 2) {
      return Row(
        children: [
          for (var i = 0; i < 2; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 4),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: _buildMediaTile(_mediaList[i]),
                ),
              ),
            ),
        ],
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: _mediaList.take(4).map((media) => _buildMediaTile(media)).toList(),
    );
  }
}

// MediaViewerPage remains the same as in the previous implementation, but you can
// use the thumbnail while the video is loading:

class MediaViewerPage extends StatefulWidget {
  final Media media;

  const MediaViewerPage({Key? key, required this.media}) : super(key: key);

  @override
  State<MediaViewerPage> createState() => _MediaViewerPageState();
}

class _MediaViewerPageState extends State<MediaViewerPage> {
  VideoPlayerController? _videoController; // Make this nullable
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.media.type == MediaType.video) {
      _videoController = VideoPlayerController.network(widget.media.url)
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
          _videoController?.play();
          _videoController?.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose(); // Dispose safely if initialized
    super.dispose();
  }

  Future<void> _downloadMedia() async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final response = await http.get(Uri.parse(widget.media.url));
        String? filePath;
        final fileName = widget.media.url.split('/').last;

        if (Platform.isIOS) {
          final dir = await getApplicationDocumentsDirectory();
          filePath = '${dir.path}/$fileName';
        }
        if (Platform.isAndroid) {
          final downloadsDir = Directory('/storage/emulated/0/Download/');
          filePath = '${downloadsDir.path}$fileName';
        }

        var ext = widget.media.url.split('.').last;

        File file = File('$filePath.$ext');
        await file.writeAsBytes(response.bodyBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded to: $filePath')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download media')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadMedia,
          ),
        ],
      ),
      body: Center(
        child: widget.media.type == MediaType.video
            ? (_isVideoInitialized
            ? AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        )
            : const CircularProgressIndicator())
            : InteractiveViewer(
          child: Image.network(
            widget.media.url,
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButton: widget.media.type == MediaType.video
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController!.value.isPlaying) {
              _videoController?.pause();
            } else {
              _videoController?.play();
            }
          });
        },
        child: Icon(
          _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      )
          : null,
    );
  }
}
