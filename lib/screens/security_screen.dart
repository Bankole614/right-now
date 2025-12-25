import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();

  bool _ob1 = true;
  bool _ob2 = true;
  bool _ob3 = true;
  bool _loading = false;

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _savePassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Password updated',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Security',
            style: TextStyle(color: theme.colorScheme.onSurface)
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'Change Password',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _passwordField(
                      controller: _old,
                      hint: 'Old Password',
                      obscure: _ob1,
                      toggle: () => setState(() => _ob1 = !_ob1),
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _passwordField(
                      controller: _new,
                      hint: 'New Password',
                      obscure: _ob2,
                      toggle: () => setState(() => _ob2 = !_ob2),
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _passwordField(
                      controller: _confirm,
                      hint: 'Confirm Password',
                      obscure: _ob3,
                      toggle: () => setState(() => _ob3 = !_ob3),
                      theme: theme,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _savePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
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

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
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
        obscureText: obscure,
        style: TextStyle(color: theme.colorScheme.onSurface),
        validator: (v) {
          if (v == null || v.isEmpty) return 'Required';
          if (hint == 'Confirm Password' && v != _new.text) {
            return 'Passwords do not match';
          }
          if (hint == 'New Password' && v.length < 6) {
            return 'Must be at least 6 chars';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          suffixIcon: IconButton(
            onPressed: toggle,
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
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