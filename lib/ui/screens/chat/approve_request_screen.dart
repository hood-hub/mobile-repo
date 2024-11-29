import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoodhub/ui/widgets/custom_button.dart';
import '../../../providers/dio_providers/dio_provider.dart';


class AdminRequestsScreen extends ConsumerStatefulWidget {
  final String groupId;

  const AdminRequestsScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  ConsumerState<AdminRequestsScreen> createState() => _AdminRequestsScreenState();
}

class _AdminRequestsScreenState extends ConsumerState<AdminRequestsScreen> {
  late Future<List<dynamic>> groupRequestsFuture;

  @override
  void initState() {
    super.initState();
    groupRequestsFuture = _fetchGroupRequests();
  }

  Future<List<dynamic>> _fetchGroupRequests() async {
    try {
      final dio = ref.read(dioServiceProvider);
      final response = await dio.getRequest(
        '/api/v1/group/get-group-requests/${widget.groupId}',
      );

      if (response.data['success'] == true) {
        return response.data['data']['groupRequests'];
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch group requests');
    }
  }

  Future<void> _approveRequest(String requestId) async {
    try {
      final dio = ref.read(dioServiceProvider);
      final response = await dio.putRequest(
        '/api/v1/group/approve-request-to-join-group/${widget.groupId}', data: {"userId": requestId}
      );

      if (response.data['success'] == true) {
        setState(() {
          groupRequestsFuture = _fetchGroupRequests(); // Refresh requests
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request approved successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error approving request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Requests'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: groupRequestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Failed to load requests'));
          }

          final requests = snapshot.data!;
          if (requests.isEmpty) {
            return const Center(child: Text('No pending requests'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading:  CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      request['profilePicture']),
                ),
                title: Text('${request['username']}'),
                trailing: CustomButton(
                  width: 100,
                  onPressed: () => _approveRequest(request['_id']),
                  text: 'Approve',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
