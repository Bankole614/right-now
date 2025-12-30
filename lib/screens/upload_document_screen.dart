import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedDocumentType = 'Evidence';
  bool _hasSelectedFile = false;
  String? _fileName;

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

  void _showUploadModal() {
    // Inherit theme data for the modal
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final modalBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final itemBgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: modalBgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildModalOption(
              Icons.camera_alt_outlined,
              'Take Photo',
              itemBgColor,
                  () {
                Navigator.pop(context);
                setState(() {
                  _fileName = 'captured_photo.jpg';
                  _hasSelectedFile = true;
                });
              },
            ),
            const Divider(height: 32),
            _buildModalOption(
              Icons.photo_library_outlined,
              'Photo Library',
              itemBgColor,
                  () {
                Navigator.pop(context);
                setState(() {
                  _fileName = 'gallery_image.jpg';
                  _hasSelectedFile = true;
                });
              },
            ),
            const Divider(height: 32),
            _buildModalOption(
              Icons.folder_outlined,
              'Choose File',
              itemBgColor,
                  () {
                Navigator.pop(context);
                setState(() {
                  _fileName = 'financial_report_q4.pdf';
                  _hasSelectedFile = true;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor = isDark ? Colors.black : const Color(0xFFF3F4F6);
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Upload Document',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryBlue,
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
            // --- MODIFICATION: Document Title Field ---
            _buildSectionLabel('Document Title', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _titleController,
              hintText: 'Enter document title',
              isDark: isDark,
            ),
            const SizedBox(height: 24),

            // --- MODIFICATION: Document Type Dropdown ---
            _buildSectionLabel('Document Type', isDark),
            const SizedBox(height: 8),
            _buildDropdownField(
              value: _selectedDocumentType,
              items: documentTypes,
              isDark: isDark,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedDocumentType = value);
                }
              },
            ),
            const SizedBox(height: 24),

            // --- MODIFICATION: File Upload Area ---
            _buildSectionLabel('File', isDark),
            const SizedBox(height: 8),
            if (_hasSelectedFile)
              _buildSelectedFileDisplay(isDark, subTextColor)
            else
              _buildUploadArea(isDark, subTextColor),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _hasSelectedFile
                ? () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Document uploaded successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.grey.shade400,
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
      ),
    );
  }

  // --- Reusable and Refactored Widgets ---

  Widget _buildSectionLabel(String label, bool isDark) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.grey[300] : Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDark,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
      onChanged: onChanged,
      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
        ),
      ),
      dropdownColor: isDark ? const Color(0xFF2C2C2E) : Colors.white,
    );
  }

  Widget _buildSelectedFileDisplay(bool isDark, Color subTextColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, color: kPrimaryBlue, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _fileName ?? 'Selected File',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red, size: 20),
            onPressed: () {
              setState(() {
                _hasSelectedFile = false;
                _fileName = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea(bool isDark, Color subTextColor) {
    return GestureDetector(
      onTap: _showUploadModal,
      child: DottedBorder(
        color: Colors.grey.shade400,
        strokeWidth: 1.5,
        dashPattern: const [6, 6],
        // MODIFICATION: The 'borderType' property is removed.
        // The radius is now controlled by the child's decoration.
        radius: const Radius.circular(12),
        // The child's shape will now define the border's shape.
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            // This color makes the inside of the border visible
            color: isDark ? const Color(0xFF1E1E1E).withOpacity(0.5) : Colors.white,
            // This radius must match the radius in DottedBorder
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.folder_open_outlined,
                  size: 36,
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tap to upload a document',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalOption(
      IconData icon,
      String label,
      Color itemBgColor,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: itemBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 24, color: kPrimaryBlue),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
