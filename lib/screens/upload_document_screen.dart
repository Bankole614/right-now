import 'package:flutter/material.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedDocumentType = 'Evidence';
  bool _hasSelectedFile = false;

  final List<String> documentTypes = [
    'Evidence',
    'Contract',
    'License',
    'Complaint',
    'Statement',
    'Court Order',
    'Brief',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Upload Document',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document Title
            const Text(
              'Document Title',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter document title',
                  hintStyle: TextStyle(color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Document Type
            const Text(
              'Document Type',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedDocumentType,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: documentTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDocumentType = value!);
                },
              ),
            ),
            const SizedBox(height: 8),

            // Show selected types as chips
            Wrap(
              spacing: 8,
              children: [
                _buildTypeChip('Contract'),
                _buildTypeChip('Evidence'),
                _buildTypeChip('License'),
              ],
            ),
            const SizedBox(height: 20),

            // Upload Area
            GestureDetector(
              onTap: () {
                setState(() => _hasSelectedFile = true);
                // Handle file picker
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.folder_outlined,
                        size: 48,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tap to upload Document',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Upload Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hasSelectedFile
                    ? () {
                  // Handle upload
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Document uploaded successfully'),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4ED8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label) {
    final selected = _selectedDocumentType == label;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2D4ED8).withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: selected ? const Color(0xFF2D4ED8) : Colors.black12,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: selected ? const Color(0xFF2D4ED8) : Colors.black54,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}