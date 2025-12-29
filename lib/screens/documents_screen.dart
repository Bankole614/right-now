import 'package:flutter/material.dart';
import 'package:right_now/screens/upload_document_screen.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> documents = [
    {
      'title': 'Plaintiff\'s Complaint',
      'date': '13 Mar 2025',
    },
    {
      'title': 'Witness Statement',
      'date': '13 Mar 2025',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Documents',
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black38, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search Documents',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Case Documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'These are files uploaded by you and your Lawyer and they are securely stored.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Documents List
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: documents.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  return _buildDocumentItem(
                    doc['title'],
                    doc['date'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UploadDocumentScreen()),
          );
        },
        backgroundColor: const Color(0xFF2D4ED8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDocumentItem(String title, String date) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2D4ED8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.description,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onSelected: (value) {
              // Handle menu actions
              if (value == 'view') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening document...')),
                );
              } else if (value == 'send') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sending to AI...')),
                );
              } else if (value == 'download') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading...')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('View')),
              const PopupMenuItem(value: 'send', child: Text('Send to AI')),
              const PopupMenuItem(value: 'download', child: Text('Download')),
            ],
          ),
        ],
      ),
    );
  }
}