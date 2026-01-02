import 'package:flutter/material.dart';
import 'package:right_now/screens/widgets/consultation_modal.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class LawyerProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;
  const LawyerProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor =
    isDark ? const Color(0xFF121212) : const Color(0xFFF3F4F6);
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Use padding for overall spacing from screen edges
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- MODIFICATION: All sections are now consistently styled cards ---
            _buildProfileHeader(
                cardBackgroundColor, textColor, subTextColor),
            const SizedBox(height: 12),
            _buildContactInfoSection(
                cardBackgroundColor, textColor, subTextColor),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'About',
              content:
              '${data['name']} is a highly experienced civil lawyer specializing in contract law, property disputes, and personal injury cases.',
              cardBackgroundColor: cardBackgroundColor,
              textColor: textColor,
              subTextColor: subTextColor,
            ),
            const SizedBox(height: 12),
            _buildExpertiseSection(
                cardBackgroundColor, textColor, subTextColor),
            const SizedBox(height: 12),
            _buildEducationSection(
                cardBackgroundColor, textColor, subTextColor),
            const SizedBox(height: 90), // Space for the floating button
          ],
        ),
      ),
      // --- NEW WIDGET: Floating bottom button for booking ---
      bottomSheet: Container(
        color: scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showConsultationModal(context);
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
              'Book Consultation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildProfileHeader(
      Color cardBgColor, Color textColor, Color subTextColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(data['avatar']),
          ),
          const SizedBox(height: 16),
          Text(
            data['name'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Civil Law', // You can pass this from data if available
            style: TextStyle(
              color: subTextColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                data['rating'],
                    (i) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${data['reviews']})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildContactInfoSection(
      Color cardBgColor, Color textColor, Color subTextColor) {
    // Note: No IntrinsicHeight needed if cards are styled individually
    return Row(
      children: [
        Expanded(
          child: _buildContactCard(
            icon: Icons.location_on,
            title: 'Location',
            value: 'Orlando, FL',
            cardBgColor: cardBgColor,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildContactCard(
            icon: Icons.phone,
            title: 'Phone',
            value: '+1 234 567 890',
            cardBgColor: cardBgColor,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildContactCard(
            icon: Icons.email,
            title: 'Email',
            value: 'sarahconor@examp...',
            cardBgColor: cardBgColor,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
        ),
      ],
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color cardBgColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: kPrimaryBlue,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: subTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildInfoCard({
    required String title,
    required String content,
    required Color cardBackgroundColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: subTextColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildExpertiseSection(
      Color cardBgColor, Color textColor, Color subTextColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas of Expertise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          _bulletPoint('Contract Law', subTextColor),
          _bulletPoint('Property Disputes', subTextColor),
          _bulletPoint('Personal Injury', subTextColor),
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme colors ---
  Widget _buildEducationSection(
      Color cardBgColor, Color textColor, Color subTextColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          _bulletPoint('University of California, Riverside', subTextColor),
          _bulletPoint('University of Miami School of Law', subTextColor),
        ],
      ),
    );
  }

  // --- MODIFICATION: Updated to accept theme color ---
  Widget _bulletPoint(String text, Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: subTextColor,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: subTextColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
