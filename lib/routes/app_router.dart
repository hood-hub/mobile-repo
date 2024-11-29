import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hoodhub/ui/screens/account/emergency_contact_screen.dart';
import 'package:hoodhub/ui/screens/auth/reset_password_token_screen.dart';
import 'package:hoodhub/ui/screens/chat/chat_item.dart';
import 'package:hoodhub/ui/screens/chat/chat_screen.dart';
import 'package:hoodhub/ui/screens/chat/messaging_screen.dart';
import 'package:hoodhub/ui/screens/create_post_screen/create_post_screen.dart';
import '../models/postmodel.dart';
import '../ui/screens/account/account_screen.dart';
import '../ui/screens/account/app_version_screen.dart';
import '../ui/screens/account/contact_support_screen.dart';
import '../ui/screens/account/profile_screen.dart';
import '../ui/screens/account/termsofuse_screen.dart';
import '../ui/screens/account/update_password_screen.dart';
import '../ui/screens/auth/login/login_screen.dart';
import '../ui/screens/auth/reset_password_screen_1.dart';
import '../ui/screens/auth/reset_password_screen_2.dart';
import '../ui/screens/auth/signup/signup_screen.dart';
import '../ui/screens/auth/signup/verfication_screen.dart';
import '../ui/screens/bottom_nav/bottom_nav_screen.dart';
import '../ui/screens/create_post_screen/create_incident_screen.dart';
import '../ui/screens/explore/explore_screen.dart';
import '../ui/screens/explore/full_map_page.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/home/social_post_page.dart';
import '../ui/screens/onboarding/address_screen.dart';
import '../ui/screens/onboarding/onboarding_screen.dart';
import '../ui/screens/onboarding/splash_screen.dart';
import '../ui/screens/onboarding/welcome_screen.dart';
import '../ui/screens/onboarding/username_screen.dart';
import '../ui/widgets/social_post.dart';

class AppRouter {
  late final GoRouter _router;

  AppRouter() {
    _router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/welcome',
          name: 'welcome',
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/sign-up',
          name: 'signUp',
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: '/verification',
          name: 'verification',
          builder: (context, state) {
            // Extract the email argument from the query parameters
            final String? email = state.queryParams['email'];
            if (email == null) {
              throw Exception('Email parameter is required for verification');
            }
            return VerificationScreen(email: email);
          },
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/reset-password',
          name: 'resetPassword',
          builder: (context, state) => ResetPasswordScreen1(),
        ),
        GoRoute(
          path: '/reset-password-token',
          name: 'resetPasswordToken',
          builder: (context, state) {
            // Extract the email argument from the query parameters
            final String email = state.queryParams['email'] ?? '';

             return ResetPasswordTokenScreen(email: email);
          },
        ),
        GoRoute(
          path: '/reset-password-new',
          name: 'resetPasswordNew',
          builder: (context, state) {
            // Extract the email argument from the query parameters
            final String email = state.queryParams['email'] ?? '';
            final String token = state.queryParams['token'] ?? '';


            return ResetPasswordScreen2(email: email, token: int.parse(token));
          },
        ),
        GoRoute(
          path: '/username',
          name: 'username',
          builder: (context, state) {
            final String userId = state.queryParams['userId'] ?? '';

            return UsernameScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/select-address',
          name: 'selectAddress',
          builder: (context, state) {
            final String userId = state.queryParams['userId'] ?? '';
            final String username = state.queryParams['username'] ?? '';

            return AddressScreen(userId: userId, username: username);
          },
        ),
        GoRoute(
          path: '/bottom-nav',
          name: 'bottomNav',
          builder: (context, state) => BottomNavScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(
          path: '/create-post',
          name: 'create-post',
          builder: (context, state) => const CreatePostScreen(),
        ),
        GoRoute(
          path: '/messages',
          name: 'messages',
          builder: (context, state) => MessagesScreen(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountScreen(),
        ),
        GoRoute(
          path: '/edit-profile',
          name: 'edit-profile',
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: '/update-password',
          name: 'update-password',
          builder: (context, state) => const UpdatePasswordScreen(),
        ),
        GoRoute(
          path: '/contact-support',
          name: 'contact-support',
          builder: (context, state) => ContactSupportScreen(),
        ),
        GoRoute(
          path: '/emergency-contact',
          name: 'emergency-contact',
          builder: (context, state) => const EmergencyContactScreen(),
        ),
        GoRoute(
          path: '/report-incident',
          name: 'report-incident',
          builder: (context, state) => const ReportIncidentScreen(),
        ),
        GoRoute(
          path: '/terms-of-use',
          name: 'terms-of-use',
          builder: (context, state) => TermsOfUseScreen(),
        ),
        GoRoute(
          path: '/app-version',
          name: 'app-version',
          builder: (context, state) => AppVersionScreen(),
        ),
        GoRoute(
          path: '/full-map',
          name: 'full-map',
          builder: (context, state) => FullMapPage(),
        ),
        GoRoute(
          path: '/chat',
          name: 'chat',
          builder: (context, state) => ChatScreen(),
        ),
        GoRoute(
          path: '/messaging',
          name: 'messaging',
          builder: (context, state) {
            // Extract chatId from queryParams
            final chatId = state.queryParams['chatId'];
            // Extract isGroup from extra, defaulting to false if not provided
            final isGroup = (state.extra as Map<String, dynamic>?)?['isGroup'] as bool? ?? false;
            final chatItemModel = (state.extra as Map<String, dynamic>?)?['chatItemModel'] as ChatItemModel;

            // Validate chatId is present
            if (chatId == null) {
              throw Exception('chatId is required for messaging route');
            }

            return MessagingScreen(chatId: chatId, isGroup: isGroup, chatItemModel: chatItemModel);
          },
        ),
        GoRoute(
          path: '/social-post',
          name: 'socialPost',
          builder: (context, state) {
            // Extract the post data from the extra parameter
            final socialPost = state.extra as SocialPost;
            return SocialPostPage(post: socialPost,);
          },
        ),
        // Add more routes as needed
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
/*      redirect: (context, state) {
        // Splash Screen redirect to Welcome Screen
        if (state.location == '/splash') {
          Future.delayed(const Duration(seconds: 3), () {
            context.push('/welcome');
          });
        }
        return null;
      },*/
    );
  }

  GoRouter get router => _router;

  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;
  RouteInformationParser<Object> get routeInformationParser => _router.routeInformationParser;
  RouteInformationProvider get routeInformationProvider => _router.routeInformationProvider;
}
