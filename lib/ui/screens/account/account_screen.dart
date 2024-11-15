import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../create_post_screen/create_post_screen.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountScreen> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    // Watch the userNotifierProvider asynchronously
    final userAsyncValue = ref.watch(userNotifierProvider);

    // Define options lists for flexibility
    final List<Map<String, dynamic>> mainOptions = [
      {'name': 'Edit profile', 'action': () => context.push('/edit-profile')},
      {'name': 'Update password', 'action': () => context.push('/update-password')},
      {'name': 'Emergency contact', 'action': () => context.push('/emergency-contact')},
    ];

    final List<Map<String, dynamic>> secondaryOptions = [
      {'name': 'Contact support', 'action': () => context.push('/contact-support')},
      {'name': 'Terms of Use', 'action': () => context.push('/terms-of-use')},
      {'name': 'App Version', 'action': () => context.push('/app-version')},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display user data based on AsyncValue state
              userAsyncValue.when(
                data: (user) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F1F3), width: 1),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user?.profilePicture != null
                            ? NetworkImage(user!.profilePicture!)
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user?.stringAddress ?? 'No address provided',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(height: 16),
              // First Options List
              OptionsList(options: mainOptions),
              const SizedBox(height: 16),
              // Second Options List
              OptionsList(options: secondaryOptions),
              const SizedBox(height: 32),
              // Logout Button
              TextButton(
                onPressed: () => _showLogoutDialog(context),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Perform logout
      await ref.read(secureStorageProvider).delete(key: 'auth_token');
      // Navigate to the Home or reset the screen state
      ref.read(bottomNavIndexProvider.notifier).state = 0;
      context.go('/login');
    }
  }
}





class OptionsList extends StatelessWidget {
  final List<Map<String, dynamic>> options;

  const OptionsList({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F1F3), width: 1),
      ),
      child: Column(
        children: List.generate(options.length, (index) {
          final item = options[index];
          return Column(
            children: [
              ListTile(
                title: Text(
                  item['name'],
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: item['action'],
              ),
              // Divider between items, except the last one
              if (index < options.length - 1)
                const Divider(
                  height: 1,
                  color: Color(0xFFF1F1F3),
                ),
            ],
          );
        }),
      ),
    );
  }
}
