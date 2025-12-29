// lib/screens/profile_screen.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/constants.dart';
import '../providers/theme_provider.dart';
import 'edit_profile_screen.dart';
import 'security_screen.dart';
import '../widgets/delete_account_bottom_sheet.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _biometricEnabled = false;
  bool _appearanceExpanded = false;
  final bool _loggingOut = false;
  bool _deletingAccount = false;

  Widget _tile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (trailing != null)
              trailing
            else
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  // Inline segmented control UI (matches the image you provided)
  Widget _buildAppearanceRow() {
    final ThemeMode current = ref.read(themeProvider);
    ThemeMode selected = current;

    // track color: use a subtle surfaceVariant or fallback on surface
    final Color baseSurface = Theme.of(context).colorScheme.surface;
    final Color surfaceVariant =
        Theme.of(context).colorScheme.surfaceVariant ?? baseSurface;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color trackColor = surfaceVariant.withOpacity(isDark ? 0.12 : 0.6);

    final Color selectedTextColor = Colors.white;
    final Color unselectedTextColor = Theme.of(
      context,
    ).colorScheme.onSurface.withOpacity(0.9);

    Widget option(String label, ThemeMode mode) {
      final bool active = selected == mode;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            // update selection immediately and persist
            selected = mode;
            ref.read(themeProvider.notifier).setTheme(mode);
            // reflect selection visually by rebuilding
            setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? kPrimaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: active ? selectedTextColor : unselectedTextColor,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 4, right: 4),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black.withOpacity(0.03)
                  : Colors.black.withOpacity(0.35),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            option('System default', ThemeMode.system),
            const SizedBox(width: 6),
            option('Dark', ThemeMode.dark),
            const SizedBox(width: 6),
            option('Light', ThemeMode.light),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmAndLogout() async {
    if (_loggingOut) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Log out',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Log out',
              style: TextStyle(color: kPrimaryBlue),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    try {
      // IMPORTANT: use rootNavigator so we replace the entire app stack (MaterialApp navigator)
      if (!mounted) return;
      Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamedAndRemoveUntil('/login', (r) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to log out: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  /// Opens the delete-account bottom sheet and, if user confirms,
  /// calls logout/cleanup and navigates to login.
  Future<void> _onDeleteAccountPressed() async {
    if (_deletingAccount) return;

    // show the bottom sheet; returns a String reason if user confirmed, null otherwise
    final String? reason = await showDeleteAccountBottomSheet(context);

    // If user cancelled, do nothing
    if (reason == null) return;

    setState(() => _deletingAccount = true);
    try {
      // TODO: Replace with your real delete-account API call.
      // For now we call logout to clear token/local state and then route to login.
      // await ref
      //     .read(authNotifierProvider.notifier)
      //     .logout(navigateToLogin: false);

      // Optionally: send 'reason' to your server here before routing.

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account deleted (UI-only).'),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      );

      Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamedAndRemoveUntil('/login', (r) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _deletingAccount = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Menu items section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildProfileHeader(isDark),
                  const SizedBox(height: 12),
                  _tile(
                    icon: Icons.person_outline,
                    label: 'Edit Profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _tile(
                    icon: Icons.lock_outline,
                    label: 'Security',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SecurityScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Biometric Login with switch
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fingerprint,
                          color: theme.colorScheme.onSurface,
                          size: 22,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Biometric Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Switch(
                          value: _biometricEnabled,
                          onChanged: (v) => setState(() => _biometricEnabled = v),
                          activeColor: kPrimaryBlue,
                          trackColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return kPrimaryBlue.withOpacity(0.5);
                            }
                            return isDark ? Colors.grey[700] : Colors.grey[300];
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Appearance tile: toggle expansion to show inline control below
                  InkWell(
                    onTap: () => setState(
                          () => _appearanceExpanded = !_appearanceExpanded,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.4)
                                : Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.palette_outlined,
                            color: theme.colorScheme.onSurface,
                            size: 22,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Appearance',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          // show chevron rotates based on expansion state
                          Transform.rotate(
                            angle: _appearanceExpanded ? math.pi : 0,
                            child: Icon(
                              Icons.expand_more,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Inline appearance control (only shown when expanded)
                  if (_appearanceExpanded) _buildAppearanceRow(),

                  const SizedBox(height: 12),

                  _tile(
                    icon: Icons.logout_outlined,
                    label: _loggingOut ? 'Logging out...' : 'Log Out',
                    onTap: () {
                      _confirmAndLogout();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Delete account button - wired to the bottom sheet
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF7F1D1D).withOpacity(0.3) // Dark red for dark theme
                          : const Color(0xFFFEE2E2), // Light red for light theme
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: _deletingAccount ? null : _onDeleteAccountPressed,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _deletingAccount
                          ? SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isDark
                              ? const Color(0xFFFECACA)
                              : const Color(0xFFF63A3A),
                        ),
                      )
                          : Text(
                        'Delete Account',
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFFFECACA) // Light red text for dark theme
                              : const Color(0xFFF63A3A), // Dark red text for light theme
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Civil Law',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                    (i) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(12)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}