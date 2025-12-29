import 'package:flutter/material.dart';
import 'package:right_now/screens/documents_screen.dart';

class CaseDetailsScreen extends StatelessWidget {
  const CaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D4ED8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Case Title Card
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John vs Nigerian Govt.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Client',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Lawyer',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Mark Cole',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Next Hearing: Nov 20 · Courtroom B',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D4ED8).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Lagos, NG',
                      style: TextStyle(
                        color: Color(0xFF2D4ED8),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Quick Actions
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(
                    Icons.psychology_outlined,
                    'AI\nAssistant',
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening AI Assistant...')),
                      );
                    },
                  ),
                  _buildQuickAction(
                    Icons.upload_file_outlined,
                    'Upload\nDocument',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DocumentsScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Documents...')),
                      );
                    },
                  ),
                  _buildQuickAction(
                    Icons.chat_outlined,
                    'Open\nChat',
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Chat...')),
                      );
                    },
                  ),
                  _buildQuickAction(
                    Icons.task_outlined,
                    'Create\nTask',
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creating Task...')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Timeline Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Please, upload the signed contract',
                    date: 'Nov 12',
                  ),
                  const SizedBox(height: 12),
                  _buildTimelineItem(
                    icon: Icons.description_outlined,
                    title: 'Contract.pdf',
                    date: 'Nov 12',
                  ),
                  const SizedBox(height: 12),
                  _buildTimelineItem(
                    icon: Icons.add_circle_outline,
                    title: 'Hearing Added',
                    subtitle: 'Nov 20 · Courtroom B',
                    date: 'Nov 12',
                  ),
                  const SizedBox(height: 12),
                  _buildTimelineItem(
                    icon: Icons.task_alt_outlined,
                    title: 'Task Created',
                    subtitle: 'Draft initial demand',
                    date: 'Nov 12',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Documents Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF2D4ED8)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
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
  }) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentCard(String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2D4ED8).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D4ED8).withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: Color(0xFF2D4ED8),
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D4ED8),
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