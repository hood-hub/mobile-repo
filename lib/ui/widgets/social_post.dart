import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/postmodel.dart';
import '../../providers/home_provider.dart';
import '../theme/app_colors.dart';
import 'media_page.dart';



class SocialPost extends ConsumerStatefulWidget {
  final PostModel post;
  final String name;
  final bool initialIsBookmarked;
  final bool showGroupHeader;
  final bool disableNavigation;
  final Function(bool)? onLikeChanged;
  final Function()? onComment;
  final Function()? onShare;
  final Function(bool)? onBookmarkChanged;

  const SocialPost({
    Key? key,
    required this.post,
    required this.name,
    this.initialIsBookmarked = false,
    this.showGroupHeader = false,
    this.disableNavigation = false,
    this.onLikeChanged,
    this.onComment,
    this.onShare,
    this.onBookmarkChanged,
  }) : super(key: key);

  @override
  ConsumerState<SocialPost> createState() => _SocialPostState();
}

class _SocialPostState extends ConsumerState<SocialPost> with SingleTickerProviderStateMixin {
  late PostModel _post;
  late bool isLiked;
  late bool isBookmarked;
  late int likeCount;
  late AnimationController _likeController;
  late Animation<double> _likeScale;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    isLiked = false;
    isBookmarked = widget.initialIsBookmarked;
    likeCount = _post.noOfLikes;

    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _likeScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _likeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }


  Future<void> _handleLike() async {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
      _post = _post.copyWith(noOfLikes: likeCount);
    });

    if (isLiked) {
      // Call the likePost provider
      final success = await ref.read(likePostProvider(id: _post.id).future);
      if (!success) {
        // If like fails, revert the state
        setState(() {
          isLiked = !isLiked;
          likeCount -= 1;
        });
      }
    } else {
      // Call the unLikePost provider
      final success = await ref.read(unLikePostProvider(id: _post.id).future);
      if (!success) {
        // If unlike fails, revert the state
        setState(() {
          isLiked = !isLiked;
          likeCount += 1;
        });
      }
    }

    // Animate like button
    if (isLiked) {
      _likeController.forward().then((_) => _likeController.reverse());
    }

    widget.onLikeChanged?.call(isLiked);
  }

  void _handleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
    widget.onBookmarkChanged?.call(isBookmarked);
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  String _calculateTimeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years years ago';
    }
  }

  void _navigateToPostPage(BuildContext context) {
    // Check if the current route is already the SocialPostPage
    if (GoRouter.of(context).location == '/social-post') {
      return; // Do nothing if already inside SocialPostPage
    }

    // Navigate using GoRouter
    GoRouter.of(context).pushNamed(
      'socialPost',
      extra: widget, // Pass the current SocialPost widget instance as extra data
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPostPage(context),
      child: Column(
        children: [
          Divider(
            thickness: 0.5,
            color: const Color(0xFFCCCDCF),
            height: 0.5,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showGroupHeader)
                  const Row(
                    children: [
                      Icon(Icons.group, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '[Group/Community Name]',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                if (widget.showGroupHeader) const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(_post.userId?.profilePicture ?? 'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _post.userId?.username ?? 'Username',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Wrap(
                            spacing: 4, // Small space between elements
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (_post.stringAddress != null && _post.stringAddress!.isNotEmpty)
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
                                  child: Text(
                                    _post.stringAddress ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              Text(
                                "•", // Separator
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                GetTimeAgo.parse(_post.createdAt),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _post.text,
                  style: const TextStyle(fontSize: 16, color: AppColors.grey700, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                if (_post.media.isNotEmpty) MediaGridWidget(mediaUrls: _post.media),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        ScaleTransition(
                          scale: _likeScale,
                          child: IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : AppColors.grey700,
                            ),
                            onPressed: _handleLike,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        Text(
                          _formatCount(likeCount),
                          style: const TextStyle(fontSize: 14, color: AppColors.grey700),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset('assets/images/comments.svg'),
                          onPressed: () => _navigateToPostPage(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Text(
                          _formatCount(_post.noOfComments),
                          style: const TextStyle(fontSize: 14, color: AppColors.grey700),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: SvgPicture.asset('assets/images/share.svg'),
                      onPressed: widget.onShare,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: AppColors.grey700,
                      ),
                      onPressed: _handleBookmark,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    if (_post.media.isEmpty) return const SizedBox.shrink();

    // Convert URLs to Media objects
    final mediaList = _post.media.map((url) => Media.fromUrl(url)).toList();

    Widget buildMediaTile(Media media) {

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
              media.type == MediaType.video
                  ? Stack(
                alignment: Alignment.center,
                children: [
                  getVideoThumbnail(media),
                  /*Image.network(
                    // You might want to generate/store thumbnails for videos
                    media.url.replaceAll('.mp4', '_thumb.jpg'),
                    fit: BoxFit.cover,
                  ),*/
                  const Icon(
                    Icons.play_circle_outline,
                    size: 48,
                    color: Colors.white,
                  ),
                ],
              )
                  : Image.network(
                media.url,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      );
    }

    if (mediaList.length == 1) {
      return AspectRatio(
        aspectRatio: 1.5,
        child: buildMediaTile(mediaList[0]),
      );
    }

    if (mediaList.length == 2) {
      return Row(
        children: [
          for (var i = 0; i < 2; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 4),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: buildMediaTile(mediaList[i]),
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
      children: mediaList.take(4).map((media) => buildMediaTile(media)).toList(),
    );
  }
}

getVideoThumbnail(Media media) async {
  XFile thumbnailFile = await VideoThumbnail.thumbnailFile(
    video: media.url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.WEBP,
    maxHeight: 64,
    // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    quality: 75,
  );

  return await Image.file(File(thumbnailFile.path));
}
