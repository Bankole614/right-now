import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_now/utils/constants.dart';
import 'package:right_now/widgets/upload_image_modal.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  State<CompleteRegistrationScreen> createState() =>
      _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState extends State<CompleteRegistrationScreen> {
  XFile? _imageFile;
  int _currentStep = 0;

  final _displayNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _selectedContactMethod = 'In-app';

  final List<String> _contactMethods = ['In-app', 'Phone', 'Email'];

  void _showImageUploadModal() {
    showUploadImageModal(context, (file) {
      setState(() {
        _imageFile = file;
      });
    });
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete Registration',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            _buildStepper(),
            const SizedBox(height: 32),
            _buildPhotoUpload(isDark),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'Display Name',
              controller: _displayNameController,
              isDark: isDark,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Phone Number',
              controller: _phoneNumberController,
              isDark: isDark,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Preferred Contact Method',
              value: _selectedContactMethod,
              items: _contactMethods,
              isDark: isDark,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedContactMethod = value);
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(context, isDark),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStep(index: 0, title: 'Basic Info'),
        _buildStepDivider(),
        _buildStep(index: 1, title: 'Additional Info'),
        _buildStepDivider(),
        _buildStep(index: 2, title: 'Legal Preferences'),
      ],
    );
  }

  Widget _buildStep({required int index, required String title}) {
    final bool isActive = index == _currentStep;
    final bool isCompleted = index < _currentStep;
    final color = isActive || isCompleted ? kPrimaryBlue : Colors.grey[300];

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? kPrimaryBlue : Colors.transparent,
            border: Border.all(color: color!),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive || isCompleted ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black) : Colors.grey,

          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 28.0),
        child: Divider(thickness: 1.5),
      ),
    );
  }

  Widget _buildPhotoUpload(bool isDark) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showImageUploadModal,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
            backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
            child: _imageFile == null
                ? Icon(
              Icons.camera_alt,
              size: 40,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            )
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Upload Photo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
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
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
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
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Handle Save logic
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: kPrimaryBlue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle Next logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
