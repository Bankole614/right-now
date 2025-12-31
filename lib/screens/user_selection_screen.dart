import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Who are you?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you\'d like to use RightNow',
                style: TextStyle(
                  fontSize: 16,
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 32),
              // Use Expanded to allow the cards to fill available space
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // --- FIX APPLIED HERE ---
                    // Wrap each card in Expanded to give it a defined height
                    Expanded(
                      child: UserRoleCard(
                        title: 'Lawyer',
                        description:
                        'Manage multiple cases, assign tasks, and communicate with clients',
                        imagePath: 'assets/images/lawyer.png',
                        isSelected: selectedRole == 'lawyer',
                        isDark: isDark,
                        onTap: () {
                          setState(() {
                            selectedRole = 'lawyer';
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // --- FIX APPLIED HERE ---
                    Expanded(
                      child: UserRoleCard(
                        title: 'Client',
                        description:
                        'Track your case, upload documents, and ask the AI plain-language questions',
                        imagePath: 'assets/images/client.png',
                        isSelected: selectedRole == 'client',
                        isDark: isDark,
                        onTap: () {
                          setState(() {
                            selectedRole = 'client';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedRole != null
                      ? () {
                    // Navigate to the next screen, passing the role
                    Navigator.pushNamed(context, '/signup');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'By continuing, you agree to our Terms of Service',
                  style: TextStyle(
                    fontSize: 14,
                    color: subTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserRoleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const UserRoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Use a subtle border for dark mode when not selected
          border: Border.all(
            color: isSelected
                ? kPrimaryBlue
                : (isDark ? Colors.grey[800]! : Colors.transparent),
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isDark
              ? null // No shadow in dark mode for a flatter look
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          // The inner radius should be slightly smaller than the container's
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                // Add a color blend for dark mode to tone down the image
                color: isDark ? Colors.black.withOpacity(0.3) : null,
                colorBlendMode: isDark ? BlendMode.darken : null,
              ),
              // Gradient overlay to ensure text is always readable
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.4, 1.0], // Start gradient lower
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              // Text content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.4,
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
}
