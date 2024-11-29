import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../models/message_model.dart';
import '../../theme/theme.dart';
import '../../widgets/media_page.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final bool showSender;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.showSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaList = message.media.map((url) => Media.fromUrl(url)).toList();

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? AppColors.primary : AppColors.grey500,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender) ...[
              Text(
                message.sender.username,
                style: TextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey800,
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (message.content.isNotEmpty)
              Text(
                message.content,
                style: TextStyles.bodyMedium.copyWith(
                  color:/* isCurrentUser ? */AppColors.white /*: AppColors.grey500*/,
                ),
              ),
            if (mediaList.isNotEmpty) ...[
              const SizedBox(height: 8),
              MediaGridWidget(mediaUrls: message.media),
            ],
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(message.createdAt),
              style: TextStyles.bodyMedium.copyWith(
                color: isCurrentUser
                    ? AppColors.white.withOpacity(0.7)
                    : AppColors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Initialize timezone data
    tz_data.initializeTimeZones();

    // Get Toronto timezone
    final torontoTimezone = tz.getLocation('America/Toronto');

    // Convert timestamp to Toronto timezone
    final torontoTime = tz.TZDateTime.from(timestamp, torontoTimezone);

    final now = tz.TZDateTime.now(torontoTimezone);
    final difference = now.difference(torontoTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(torontoTime);
    } else {
      return DateFormat('h:mm a').format(torontoTime);
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
    _generateThumbnails();
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
            if (media.type == MediaType.video && media.thumbnailPath != null)
              Image.file(
                File(media.thumbnailPath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.video_library),
                  );
                },
              )
            else if (media.type == MediaType.image)
              Image.network(
                media.url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  );
                },
              )
            else
              Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image),
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

class MediaViewerPage extends StatefulWidget {
  final Media media;

  const MediaViewerPage({Key? key, required this.media}) : super(key: key);

  @override
  State<MediaViewerPage> createState() => _MediaViewerPageState();
}

class _MediaViewerPageState extends State<MediaViewerPage> {
  VideoPlayerController? _videoController;
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
    _videoController?.dispose();
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
    );
  }
}
