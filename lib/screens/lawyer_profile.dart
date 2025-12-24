import 'package:flutter/material.dart';

class LawyerProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;
  const LawyerProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Text(
          data['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2D4ED8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile header card
            _buildProfileHeader(),
            const SizedBox(height: 16),

            // Contact info cards (location, phone, email)
            _buildContactInfoSection(),
            const SizedBox(height: 16),

            // About section
            _buildInfoCard(
              title: 'About',
              content: 'Sarah Conor is a highly experienced civil lawyer specializing in contract law, property disputes, and personal injury cases.',
            ),
            const SizedBox(height: 16),

            // Areas of Expertise section
            _buildExpertiseSection(),
            const SizedBox(height: 16),

            // Education section
            _buildEducationSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // Profile Header with Avatar, Name, and Rating
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Civil Law',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                    (i) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '(12)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Contact Info Section (Location, Phone, Email)
  Widget _buildContactInfoSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildContactCard(
            icon: Icons.location_on,
            title: 'Location',
            value: 'Orlando, FL',
          ),
          _buildContactCard(
            icon: Icons.phone,
            title: 'Phone',
            value: '+1 234 567 890',
          ),
          _buildContactCard(
            icon: Icons.email,
            title: 'Email',
            value: 'sarahconor@examp...',
          ),
        ],
      ),
    );
  }

  // Contact Card Widget (same format as statistics cards)
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: const Color(0xFF2D4ED8),
              size: 24,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Generic Info Card for sections like "About"
  Widget _buildInfoCard({
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Areas of Expertise Section
  Widget _buildExpertiseSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Areas of Expertise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          _bulletPoint('Contract Law'),
          _bulletPoint('Property Disputes'),
          _bulletPoint('Personal Injury'),
        ],
      ),
    );
  }

  // Education Section
  Widget _buildEducationSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Education',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          _bulletPoint('University of California, Riverside'),
          _bulletPoint('University of Miami School of Law'),
        ],
      ),
    );
  }

  // Bullet Point Helper
  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
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