import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hoodhub/ui/screens/chat/chat_screen.dart';
import '../../theme/app_colors.dart';
import '../account/account_screen.dart';
import '../create_post_screen/create_post_screen.dart';
import '../explore/explore_screen.dart';
import '../home/home_screen.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  // List of screens for each navigation item
  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const CreatePostScreen(),
    const ChatScreen(),
    const AccountScreen(),
  ];

  // Maintain state for each screen using a Map
  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    // Watch the current selected index from the provider
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomNavHeight = screenHeight * 0.10; // 10% of the screen height

    return Scaffold(
      body: Stack(
        children: _screens.asMap().map((index, screen) {
          return MapEntry(
            index,
            Offstage(
              offstage: selectedIndex != index,
              child: Navigator(
                key: _navigatorKeys[index],
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => screen,
                ),
              ),
            ),
          );
        }).values.toList(),
      ),
      bottomNavigationBar: SizedBox(
        height: bottomNavHeight,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (int index) {
            if (selectedIndex == index) {
              // If the current tab is tapped again, pop to the first route
              _navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
            } else {
              // Update the selected index using the StateProvider
              ref.read(bottomNavIndexProvider.notifier).state = index;
            }
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/home.svg',
                color: selectedIndex == 0 ? AppColors.primary : AppColors.grey500,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/explore.svg',
                color: selectedIndex == 1 ? AppColors.primary : AppColors.grey500,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/post.svg',
                color: selectedIndex == 2 ? AppColors.primary : AppColors.grey500,
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/messages.svg',
                color: selectedIndex == 3 ? AppColors.primary : AppColors.grey500,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/profile.svg',
                color: selectedIndex == 4 ? AppColors.primary : AppColors.grey500,
              ),
              label: 'Account',
            ),
/*            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 12, // Set this based on the size you desire
              ),
              label: 'Account',
            ),*/
          ],
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey500,
        ),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: Center(child: Text('Messages Screen')),
    );
  }
}

