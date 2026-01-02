import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

void showConsultationModal(BuildContext context) {
  // Inherit theme data for the modal
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  final modalBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Make modal background transparent
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: modalBgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: const ConsultationModal(),
    ),
  );
}

class ConsultationModal extends StatelessWidget {
  const ConsultationModal({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    // --- FIX APPLIED HERE ---
    // Added the '!' operator to Colors.grey[600] to make it non-nullable.
    final subTextColor = isDark ? Colors.grey[300]! : Colors.grey[600]!;

    return Padding(
      // Add padding to handle the keyboard view
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book Consultation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: textColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField(
              label: 'Full Name', isDark: isDark, subTextColor: subTextColor),
          const SizedBox(height: 16),
          _buildTextField(
              label: 'Email Address',
              isDark: isDark,
              subTextColor: subTextColor),
          const SizedBox(height: 16),
          _buildTextField(
              label: 'Phone Number', isDark: isDark, subTextColor: subTextColor),
          const SizedBox(height: 16),
          _buildTextField(
              label: 'Case Description',
              maxLines: 4,
              isDark: isDark,
              subTextColor: subTextColor),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Consultation booked successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Padding at the bottom
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to be theme-aware ---
  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    required bool isDark,
    required Color subTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: subTextColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor:
            isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
