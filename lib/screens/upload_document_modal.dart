import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';

class UploadDocumentModal extends StatelessWidget {
  final Function(String source, dynamic file) onFileSelected;

  const UploadDocumentModal({
    super.key,
    required this.onFileSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
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

          // Take Photo
          _buildOption(
            icon: Icons.camera_alt_outlined,
            label: 'Take Photo',
            onTap: () {
              Navigator.pop(context);
              _takePhoto(context);
            },
          ),
          const Divider(height: 32),

          // Photo Library
          _buildOption(
            icon: Icons.photo_library_outlined,
            label: 'Photo Library',
            onTap: () {
              Navigator.pop(context);
              _pickFromGallery(context);
            },
          ),
          const Divider(height: 32),

          // Choose File
          _buildOption(
            icon: Icons.folder_outlined,
            label: 'Choose File',
            onTap: () {
              Navigator.pop(context);
              _pickFile(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 24, color: Colors.black87),
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

  void _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      onFileSelected('camera', photo);
    }

    // For demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Camera would open here')),
    );
  }

  void _pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onFileSelected('gallery', image);
    }

    // For demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gallery would open here')),
    );
  }

  void _pickFile(BuildContext context) async {
    // Uncomment when using file_picker package
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    // );
    // if (result != null) {
    //   onFileSelected('file', result.files.first);
    // }

    // For demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File picker would open here')),
    );
  }
}

// Helper function to show the modal
void showUploadDocumentModal(
    BuildContext context,
    Function(String source, dynamic file) onFileSelected,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => UploadDocumentModal(onFileSelected: onFileSelected),
  );
}