import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildStatisticsSection(),
                    const SizedBox(height: 24),
                    _buildAppointmentSection(context),
                    const SizedBox(height: 20),
                    _buildQuickActionsSection(),
                    const SizedBox(height: 24),
                    _buildRecentMessagesSection(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // App Bar
  Widget _buildAppBar() {
    return Container(
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Client Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Header with user info
  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
          radius: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello,',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'John Doe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, size: 26),
        ),
      ],
    );
  }

  // Statistics Section
  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatisticsCard('4', 'Active Cases'),
              _buildStatisticsCard('3', 'Unread Messages'),
              _buildStatisticsCard('2', 'Upcoming Hearings'),
            ],
          ),
        ),
      ],
    );
  }

  // Statistics Card Widget
  Widget _buildStatisticsCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Today's Appointment Section
  Widget _buildAppointmentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Appointment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        _buildAppointmentCard(context),
      ],
    );
  }

  // Appointment Card Widget
  Widget _buildAppointmentCard(BuildContext context) {
    return Container(
      // The main container keeps the background image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/back.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16), // Restored original padding
      child: Column(
        children: [
          Row(
            children: [
              // AVATAR
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage('https://i.pravatar.cc/150?img=12'),
                ),
              ),
              const SizedBox(width: 14),
              // NAME, TITLE, AND CALL BUTTON
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAME AND TITLE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mr. Brandon',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Family Lawyer',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    // CALL BUTTON
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call, color: kPrimaryBlue),
                        iconSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // DATE AND TIME SECTION
          Container(
            // 1. Set background to semi-transparent white
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10), // Added some rounding
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: const [
                    // 2. Change icon color for readability
                    Icon(Icons.calendar_today, size: 20, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'July 8, 2025',
                      // 3. Change text color for readability
                      style: TextStyle(color: Colors.white,),
                    ),
                  ],
                ),
                // Time
                Row(
                  children: const [
                    // 2. Change icon color for readability
                    Icon(Icons.access_time, size: 20, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      '10:30am - 11:30am',
                      // 3. Change text color for readability
                      style: TextStyle(color: Colors.white,),
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

  // Quick Actions Section
  // Quick Actions Section
  Widget _buildQuickActionsSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [          _buildQuickCard(
          color: Color(0xFFFFFFE5),
          icon: Icons.chat_outlined,
          iconColor: Color(0xFFF2C94C), // Icon color for AI Assistant
          title: 'AI Assistant',
          subtitle: 'Get instant guidance on your case. Summarize your documents',
          onTap: () {},
        ),
          _buildQuickCard(
            color: const Color(0xFFE1E6FF),
            icon: Icons.search,
            iconColor: Color(0xFF2F80ED), // Icon color for Discover
            title: 'Discover',
            subtitle: 'Search for lawyers willing to take up your cases.',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Quick Card Widget
  Widget _buildQuickCard({
    required Color color,
    required IconData icon,
    required Color iconColor, // Added parameter for icon color
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The container around the icon has been removed
              Icon(
                icon,
                color: iconColor, // Use the new iconColor parameter
                size: 32, // Increased size for better visibility
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E3E3E),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF4F4F4F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Recent Messages Section
  Widget _buildRecentMessagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        _buildRecentMessageItem(
          name: 'Jennifer Hudson',
          message: 'Please, send me the latest update on the contract.',
          timeAgo: '2 days ago',
          avatarId: '5',
        ),
        _buildRecentMessageItem(
          name: 'Peter Gray',
          message: 'Thanks, I received the documents.',
          timeAgo: '3 days ago',
          avatarId: '8',
        ),
      ],
    );
  }

  // Recent Message Item Widget
  Widget _buildRecentMessageItem({
    required String name,
    required String message,
    required String timeAgo,
    required String avatarId,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
            NetworkImage('https://i.pravatar.cc/150?img=$avatarId'),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            timeAgo,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
