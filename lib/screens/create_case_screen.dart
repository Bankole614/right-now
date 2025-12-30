import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class CreateCaseScreen extends StatefulWidget {
  const CreateCaseScreen({super.key});

  @override
  State<CreateCaseScreen> createState() => _CreateCaseScreenState();
}

class _CreateCaseScreenState extends State<CreateCaseScreen> {
  int _currentStep = 0;
  final TextEditingController _caseTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(); // Controller for location

  String? _selectedCaseType = 'Contract'; // Use nullable for hint
  bool _isConfidential = true;

  // To hold the selected date and time
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> caseTypes = [
    'Contract',
    'Property',
    'Family',
    'Criminal',
    'Civil',
    'Corporate',
  ];

  @override
  void dispose() {
    _caseTitleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor = isDark ? Colors.black : const Color(0xFFF9F9F9);
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Create Case',
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
                _buildStepIndicator(2, 'Participants', isActive: _currentStep >= 1),
                _buildStepLine(isActive: _currentStep > 1),
                _buildStepIndicator(3, 'Schedule', isActive: _currentStep >= 2),
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
                key: ValueKey<int>(_currentStep), // Important for AnimatedSwitcher
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

    // On steps 2 and 3 (index 1 and 2), use the new stacked layout
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
        // On the last step, show 'Create Case', otherwise show 'Next'
        _currentStep == 2 ? _buildCreateCaseButton() : _buildNextButton(),
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
        // Placeholder save action
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
        onPressed: () => setState(() => _currentStep++),
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

  Widget _buildCreateCaseButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Case created successfully!'),
                backgroundColor: Colors.green),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: const Text('Create Case',
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
        return _buildBasicInfoStep(isDark, cardBackgroundColor);
      case 1:
        return _buildParticipantsStep(isDark, cardBackgroundColor);
      case 2:
        return _buildScheduleStep(isDark, cardBackgroundColor);
      default:
        return const SizedBox.shrink();
    }
  }

  // --- Reusable Form Field Widgets ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool isDark,
    int maxLines = 1,
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
          maxLines: maxLines,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
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

  Widget _buildDropdownField({
    required String? value,
    required String label,
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
          items:
          items.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
          onChanged: onChanged,
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
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

  // --- Step 1: Basic Info ---
  Widget _buildBasicInfoStep(bool isDark, Color cardBackgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _caseTitleController,
          label: 'Case Title',
          hintText: 'E.g. John vs Nigerian Govt',
          isDark: isDark,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _descriptionController,
          label: 'Description',
          hintText: 'Enter case description...',
          isDark: isDark,
          maxLines: 5,
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          value: _selectedCaseType,
          label: 'Case Type',
          items: caseTypes,
          isDark: isDark,
          onChanged: (value) => setState(() => _selectedCaseType = value),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Confidential Case',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Switch(
                value: _isConfidential,
                onChanged: (value) => setState(() => _isConfidential = value),
                activeColor: kPrimaryBlue,
                thumbColor: MaterialStateProperty.all(Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 2: Participants ---
  Widget _buildParticipantsStep(bool isDark, Color cardBackgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Participants',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Add clients, lawyers, and other participants to this case.',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          ),
          child: Column(
            children: [
              _buildParticipantItem('Client', 'Add client'),
              const Divider(height: 32),
              _buildParticipantItem('Co-counsel', 'Add co-counsel'),
              const Divider(height: 32),
              _buildParticipantItem('Witness', 'Add witness'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantItem(String role, String hint) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(hint,
                  style: TextStyle(fontSize: 13, color: Colors.grey[500])),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            /* Add participant logic */
          },
          style: TextButton.styleFrom(
            foregroundColor: kPrimaryBlue,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildScheduleStep(bool isDark, Color cardBackgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Schedule Hearing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Set up the first hearing date and location.',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        _buildScheduleField(
          label: 'Date',
          hint: _selectedDate == null
              ? 'Select date'
              : "${_selectedDate!.toLocal()}".split(' ')[0],
          isDark: isDark,
          icon: Icons.calendar_today_outlined,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
        ),
        const SizedBox(height: 20),
        _buildScheduleField(
          label: 'Time',
          hint: _selectedTime == null
              ? 'Select time'
              : _selectedTime!.format(context),
          isDark: isDark,
          icon: Icons.access_time_outlined,
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null && picked != _selectedTime) {
              setState(() {
                _selectedTime = picked;
              });
            }
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _locationController,
          label: 'Location',
          hintText: 'Enter courtroom or location',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildScheduleField({
    required String label,
    required String hint,
    required bool isDark,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    // Determine if the hint text is a placeholder or a selected value
    final bool isValueSelected = hint != 'Select date' && hint != 'Select time';

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
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: isValueSelected
                      ? (isDark ? Colors.white : Colors.black)
                      : Colors.grey[500],
                  fontSize: 16,
                ),
                filled: true,
                fillColor:
                isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
                prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
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
          ),
        ),
      ],
    );
  }
}
