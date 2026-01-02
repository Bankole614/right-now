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

class _CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  // Image picker
  XFile? _imageFile;

  // Current step in the registration process
  int _currentStep = 0;

  // Form controllers
  final _displayNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Contact method selection
  String _selectedContactMethod = 'In-app';
  final List<String> _contactMethods = ['In-app', 'Phone', 'Email'];

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Show image upload modal
  void _showImageUploadModal() {
    showUploadImageModal(context, (file) {
      setState(() {
        _imageFile = file;
      });
    });
  }

  // Validate current step
  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      if (_displayNameController.text.trim().isEmpty) {
        _showSnackBar('Please enter your display name');
        return false;
      }
      if (_phoneNumberController.text.trim().isEmpty) {
        _showSnackBar('Please enter your phone number');
        return false;
      }
      // Basic phone validation
      if (_phoneNumberController.text.trim().length < 10) {
        _showSnackBar('Please enter a valid phone number');
        return false;
      }
    }
    return true;
  }

  // Show snackbar message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Complete registration
  void _completeRegistration() {
    if (!_validateCurrentStep()) return;

    _showSnackBar('Registration completed!');
    Navigator.pop(context);
    // TODO: Implement registration completion logic
    // Navigator.pushReplacement(context, MaterialPageRoute(...));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor = isDark ? Colors.black : const Color(0xFFF9F9F9);
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Step Indicator
          Container(
            color: cardBackgroundColor,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Row(
              children: [
                _buildStepIndicator(1, 'Basic Info', isActive: _currentStep >= 0),
                _buildStepLine(isActive: _currentStep > 0),
                _buildStepIndicator(2, 'Additional', isActive: _currentStep >= 1),
                _buildStepLine(isActive: _currentStep > 1),
                _buildStepIndicator(3, 'Preferences', isActive: _currentStep >= 2),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Form Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<int>(_currentStep),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildStepContent(isDark, cardBackgroundColor),
                ),
              ),
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: SafeArea(
              child: _buildActionButtons(),
            ),
          ),
        ],
      ),
    );
  }

  // --- Button Builder Logic ---
  Widget _buildActionButtons() {
    // On the first step (index 0), show 'Save' and 'Next' side-by-side
    if (_currentStep == 0) {
      return Row(
        children: [
          Expanded(child: _buildSaveButton()),
          const SizedBox(width: 12),
          Expanded(child: _buildNextButton()),
        ],
      );
    }

    // On steps 2 and 3 (index 1 and 2), use the stacked layout
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: _buildBackButton()),
            const SizedBox(width: 12),
            Expanded(child: _buildSaveButton()),
          ],
        ),
        const SizedBox(height: 12),
        // On the last step, show 'Complete', otherwise show 'Next'
        _currentStep == 2 ? _buildCompleteButton() : _buildNextButton(),
      ],
    );
  }

  // --- Individual Button Widgets ---
  Widget _buildBackButton() {
    return OutlinedButton(
      onPressed: () => setState(() => _currentStep--),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('Back',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSaveButton() {
    return OutlinedButton(
      onPressed: () {
        if (!_validateCurrentStep()) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Progress Saved!'), backgroundColor: Colors.green),
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: kPrimaryBlue),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('Save',
          style: TextStyle(
              color: kPrimaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!_validateCurrentStep()) return;
          setState(() => _currentStep++);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: const Text('Next',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCompleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _completeRegistration,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: const Text('Complete',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- Step Indicator Widgets ---
  Widget _buildStepIndicator(int step, String label, {required bool isActive}) {
    final color = isActive ? kPrimaryBlue : Color(0xFFB6B6B6);
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? kPrimaryBlue : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? kPrimaryBlue : Color(0xFF262626),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 34, left: 4, right: 4),
        color: isActive ? kPrimaryBlue : Color(0xFFB6B6B6),
      ),
    );
  }

  // --- Step Content Widgets ---
  Widget _buildStepContent(bool isDark, Color cardBackgroundColor) {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep(isDark);
      case 1:
        return _buildAdditionalInfoStep(isDark);
      case 2:
        return _buildLegalPreferencesStep(isDark);
      default:
        return const SizedBox.shrink();
    }
  }

  // Step 1: Basic Info
  Widget _buildBasicInfoStep(bool isDark) {
    return Column(
      children: [
        _buildPhotoUpload(isDark),
        const SizedBox(height: 32),
        _buildTextField(
          label: 'Display Name',
          controller: _displayNameController,
          isDark: isDark,
          hint: 'Enter your display name',
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: 'Phone Number',
          controller: _phoneNumberController,
          isDark: isDark,
          keyboardType: TextInputType.phone,
          hint: '+234 XXX XXX XXXX',
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
    );
  }

  // Step 2: Additional Info (Placeholder)
  Widget _buildAdditionalInfoStep(bool isDark) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            size: 80,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This step will contain additional profile information',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Step 3: Legal Preferences (Placeholder)
  Widget _buildLegalPreferencesStep(bool isDark) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.gavel,
            size: 80,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Legal Preferences',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review and accept terms and conditions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Build photo upload widget
  Widget _buildPhotoUpload(bool isDark) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showImageUploadModal,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                backgroundImage:
                _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                child: _imageFile == null
                    ? Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: kPrimaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _imageFile == null ? 'Upload Photo' : 'Change Photo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  // Build text field
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
    TextInputType? keyboardType,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey[300] : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey.shade500,
                width: 1.0,
              ),
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

  // Build dropdown field
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
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey[300] : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: onChanged,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey.shade500,
                width: 1.0,
              ),
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
}