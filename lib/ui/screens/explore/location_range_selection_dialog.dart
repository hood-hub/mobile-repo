import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/explore_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
class LocationRangeDialog extends ConsumerStatefulWidget {
  const LocationRangeDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<LocationRangeDialog> createState() => _LocationRangeDialogState();
}

class _LocationRangeDialogState extends ConsumerState<LocationRangeDialog> {
  String selectedRange = '20'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Filter your feed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Pick a range for your feed',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
/*            const SizedBox(height: 16),

              // All Option
            _buildOptionTile(
              'all',
              'All',
              'Shows feed of all user\'s range.',
            ),*/

            const SizedBox(height: 16),
            const Text(
              'Location Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Shows different location\'s of neighbor\'s around.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // Distance Options
            _buildOptionTile(
              '2',
              'Nearby',
              'around 2km',
            ),
            _buildOptionTile(
              '5',
              'Around 5km',
              'around 5km',
            ),
            _buildOptionTile(
              '20',
              'Around 20km',
              'around 20km',
            ),

            const SizedBox(height: 24),

            // Buttons
            CustomButton(
              text: 'Confirm',
              onPressed: () {
                // Convert selection to int and refresh provider
                final distance = selectedRange == 'all' ? 20 : int.parse(selectedRange);
                ref.refresh(getNearByUsersProvider(distance: distance));
                Navigator.pop(context, distance);
              },
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Cancel',
              color: AppColors.greyf1,
              borderColor: AppColors.greyf1,
              onPressed: () => Navigator.pop(context),
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(String value, String title, String subtitle) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedRange = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedRange == value
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: selectedRange == value
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the dialog
Future<int?> showLocationRangeDialog(BuildContext context) {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) => const LocationRangeDialog(),
  );
}