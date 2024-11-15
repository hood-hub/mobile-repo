import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hoodhub/ui/screens/home/social_post_page.dart';
import 'package:hoodhub/ui/theme/app_colors.dart';
import 'package:hoodhub/ui/theme/text_styles.dart';
import '../../widgets/filter_radio_group_widget.dart';
import '../../widgets/social_post.dart';
import 'package:hoodhub/providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          !ref.read(homePostsNotifierProvider.notifier).isLastPage) {
        ref.read(homePostsNotifierProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(homePostsNotifierProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(homePostsNotifierProvider.notifier).refresh();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: _buildTopView(),
        ),
        body: postsAsync.when(
          data: (posts) => ListView.builder(
            controller: _scrollController,
            itemCount: posts.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < posts.length) {
                final post = posts[index];
                return SocialPost(
                  post: post,
                  name: 'User ${index + 1}', // Mock user name
                  initialIsBookmarked: false,
                  showGroupHeader: false, // Show header for every third post
                  onLikeChanged: (isLiked) {
                    print('Post ${post.id} liked: $isLiked');
                  },
                  onComment: () {
                    print('Comment on post ${post.id}');
                  },
                  onShare: () {
                    print('Share post ${post.id}');
                  },
                  onBookmarkChanged: (isBookmarked) {
                    print('Post ${post.id} bookmarked: $isBookmarked');
                  },
                );
              } else {
                return ref.read(homePostsNotifierProvider.notifier).isLastPage
                    ? const SizedBox.shrink()
                    : const Center(child: CircularProgressIndicator());
              }
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Build the top view with search bar, actions, and filters
  Widget _buildTopView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildSearchAndActions(),
          const SizedBox(height: 16),
          _buildFilterOptions(),
        ],
      ),
    );
  }

  // Search bar with action items (filter and notification icons)
  Widget _buildSearchAndActions() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search, messages',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90),
                  borderSide: const BorderSide(color: Color(0xFFF1F1F3), width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90),
                  borderSide: const BorderSide(color: Color(0xFFF1F1F3), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90),
                  borderSide: const BorderSide(color: Color(0xFF6A0DAD), width: 1.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _buildCustomActionButton(
          svgAsset: 'assets/images/filter.svg',
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        _buildCustomActionButton(
          svgAsset: 'assets/images/notification.svg',
          onPressed: () {},
        ),
      ],
    );
  }

  // Filter options (All, For You, Trending)
  Widget _buildFilterOptions() {
    return FilterRadioGroupWidget(
      options: ['All', 'For You', 'Trending'],
      currentValue: 'all',
      onChanged: (newFilter) {
        final endpoint = '${newFilter.toLowerCase().replaceAll(' ', '-')}';
        ref.invalidate(getPostsProvider); // Invalidate getPostsProvider to apply the new filter
        //ref.read(getPostsProvider);
        ref.read(homeFilterProvider.notifier).updateFilter(endpoint);

      },
    );
  }

  Widget _buildCustomActionButton({required String svgAsset, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xFFF1F1F3), width: 0.83),
        ),
        child: Center(
          child: SvgPicture.asset(svgAsset),
        ),
      ),
    );
  }
}
