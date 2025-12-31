import 'package:flutter/material.dart';
import 'package:right_now/screens/chat_screen.dart';
import 'package:right_now/screens/documents_screen.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class CaseDetailsScreen extends StatelessWidget {
  const CaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400]! : Color(0xFF4D4D4D);
    // Define a theme-aware divider color
    final dividerColor = isDark ? Colors.grey[800] : Colors.grey[200];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              // Handle menu actions
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'archive', child: Text('Archive')),
              const PopupMenuItem(value: 'export', child: Text('Export')),
              const PopupMenuItem(value: 'share', child: Text('Share')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Case Title Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John vs Nigerian Govt.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Client',
                              style:
                              TextStyle(color: subTextColor, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lawyer',
                              style:
                              TextStyle(color: subTextColor, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Mark Cole',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kPrimaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Lagos, NG',
                      style: TextStyle(
                        color: kPrimaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Next Hearing: Nov 20 · Courtroom B',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.6,
                            backgroundColor: isDark
                                ? Colors.grey[800]
                                : Colors.grey.shade200,
                            valueColor:
                            const AlwaysStoppedAnimation<Color>(kPrimaryBlue),
                            minHeight: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quick Actions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.psychology_outlined,
                      label: 'AI\nAssistant',
                      cardBackgroundColor: cardBackgroundColor,
                      textColor: textColor,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Coming Soon!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.upload_file_outlined,
                      label: 'Upload\nDocument',
                      cardBackgroundColor: cardBackgroundColor,
                      textColor: textColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DocumentsScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.chat_outlined,
                      label: 'Open\nChat',
                      cardBackgroundColor: cardBackgroundColor,
                      textColor: textColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChatScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickAction(
                      icon: Icons.task_outlined,
                      label: 'Create\nTask',
                      cardBackgroundColor: cardBackgroundColor,
                      textColor: textColor,
                      onTap: () {
                        _showCreateTaskModal(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timeline Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Timeline',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  _buildTimelineItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Please, upload the signed contract',
                    date: 'Nov 12',
                    textColor: textColor,
                    subTextColor: subTextColor,
                  ),
                  // --- FIX APPLIED HERE ---
                  Divider(color: dividerColor),
                  _buildTimelineItem(
                    icon: Icons.description_outlined,
                    title: 'Contract.pdf',
                    date: 'Nov 12',
                    textColor: textColor,
                    subTextColor: subTextColor,
                  ),
                  // --- FIX APPLIED HERE ---
                  Divider(color: dividerColor),
                  _buildTimelineItem(
                    icon: Icons.add_circle_outline,
                    title: 'Hearing Added',
                    subtitle: 'Nov 20 · Courtroom B',
                    date: 'Nov 12',
                    textColor: textColor,
                    subTextColor: subTextColor,
                  ),
                  // --- FIX APPLIED HERE ---
                  Divider(color: dividerColor),
                  _buildTimelineItem(
                    icon: Icons.task_alt_outlined,
                    title: 'Task Created',
                    subtitle: 'Draft initial demand',
                    date: 'Nov 12',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Documents Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildDocumentCard('Plaintiff Compl...'),
                      const SizedBox(width: 12),
                      _buildDocumentCard('Witness State...'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Bottom spacing
          ],
        ),
      ),
    );
  }

  // --- NEW WIDGET: Bottom sheet for creating a task ---
  void _showCreateTaskModal(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final modalBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to take up more space
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        // Padding to avoid the keyboard
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: modalBgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Title and Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create a Task',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                'Only the parties involved in this case can see this task.',
                style: TextStyle(fontSize: 14, color: subTextColor),
              ),
              const SizedBox(height: 24),
              // Task Input Field
              TextField(
                autofocus: true,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your task',
                  filled: true,
                  fillColor:
                  isDark ? const Color(0xFF2C2C2E) : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: kPrimaryBlue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add task creation logic here
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task created successfully!'),
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
                    'Create',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color cardBackgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: kPrimaryBlue),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required String date,
    required Color textColor,
    required Color subTextColor,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.0,
        bottom: isLast ? 16.0 : 12.0,
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: kPrimaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: subTextColor),
                  ),
                ],
              ],
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: subTextColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPrimaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimaryBlue.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: kPrimaryBlue,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryBlue,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
