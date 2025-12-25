import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    // UI-only: simulate save
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Profile saved',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
              // Avatar and edit icon
              Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: kPrimaryBlue,
                    child: const Text(
                      'J',
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: kPrimaryBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _inputField(
                      controller: _first,
                      hint: 'First Name',
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _inputField(
                      controller: _last,
                      hint: 'Last Name',
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _inputField(
                      controller: _phone,
                      hint: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _inputField(
                      controller: _email,
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF6F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: theme.colorScheme.onSurface),
        validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF9F9F9F), width: 1.0),
          ),
        ),
      ),
    );
  }
}