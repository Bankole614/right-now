import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showUploadImageModal(
  BuildContext context,
  Function(XFile) onImageSelected,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final modalBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
  final itemBgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);
  final dividerColor = isDark ? Colors.grey[800] : Colors.grey[200];

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: modalBgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
            () async {
              final image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                onImageSelected(image);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
          Divider(height: 32, color: dividerColor),
          _buildModalOption(
            Icons.photo_library_outlined,
            'Photo Library',
            itemBgColor,
            () async {
              final image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                onImageSelected(image);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 16),
        ],
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
            child: Icon(icon, size: 24),
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
