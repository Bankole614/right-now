import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(theme),
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isDark),
                    const SizedBox(height: 24),
                    _buildStatisticsSection(theme, isDark),
                    const SizedBox(height: 24),
                    _buildAppointmentSection(context, isDark),
                    const SizedBox(height: 20),
                    _buildQuickActionsSection(theme, isDark),
                    const SizedBox(height: 24),
                    _buildRecentMessagesSection(theme, isDark),
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
  Widget _buildAppBar(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Client Dashboard',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Header with user info
  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'),
          radius: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.black54,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'John Doe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none,
            size: 26,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Statistics Section
  Widget _buildStatisticsSection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatisticsCard('4', 'Active Cases', theme, isDark),
              _buildStatisticsCard('3', 'Unread Messages', theme, isDark),
              _buildStatisticsCard('2', 'Upcoming Hearings', theme, isDark),
            ],
          ),
        ),
      ],
    );
  }

  // Statistics Card Widget
  Widget _buildStatisticsCard(String value, String label, ThemeData theme, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.black54,
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
  Widget _buildAppointmentSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Appointment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        _buildAppointmentCard(context, isDark),
      ],
    );
  }

  // Appointment Card Widget
  Widget _buildAppointmentCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/back.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16),
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
                        icon: Icon(Icons.call, color: kPrimaryBlue),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: const [
                    Icon(Icons.calendar_today, size: 20, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'July 8, 2025',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                // Time
                Row(
                  children: const [
                    Icon(Icons.access_time, size: 20, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      '10:30am - 11:30am',
                      style: TextStyle(color: Colors.white),
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
  Widget _buildQuickActionsSection(ThemeData theme, bool isDark) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuickCard(
            color: isDark ? const Color(0xFF2D2B1E) : const Color(0xFFFFFFE5),
            icon: Icons.chat_outlined,
            iconColor: const Color(0xFFF2C94C),
            title: 'AI Assistant',
            subtitle: 'Get instant guidance on your case. Summarize your documents',
            textColor: isDark ? Colors.white : const Color(0xFF3E3E3E),
            subtitleColor: isDark ? Colors.grey[400] : const Color(0xFF4F4F4F),
            onTap: () {

            },
          ),
          _buildQuickCard(
            color: isDark ? const Color(0xFF1A1F2E) : const Color(0xFFE1E6FF),
            icon: Icons.search,
            iconColor: const Color(0xFF2F80ED),
            title: 'Discover',
            subtitle: 'Search for lawyers willing to take up your cases.',
            textColor: isDark ? Colors.white : const Color(0xFF3E3E3E),
            subtitleColor: isDark ? Colors.grey[400] : const Color(0xFF4F4F4F),
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
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color? subtitleColor,
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
              Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Recent Messages Section
  Widget _buildRecentMessagesSection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        _buildRecentMessageItem(
          name: 'Jennifer Hudson',
          message: 'Please, send me the latest update on the contract.',
          timeAgo: '2 days ago',
          avatarId: '5',
          theme: theme,
          isDark: isDark,
        ),
        _buildRecentMessageItem(
          name: 'Peter Gray',
          message: 'Thanks, I received the documents.',
          timeAgo: '3 days ago',
          avatarId: '8',
          theme: theme,
          isDark: isDark,
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
    required ThemeData theme,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark ? null : [
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.black54,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            timeAgo,
            style: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.black45,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}