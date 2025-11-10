  // lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  final List<_OnboardPageData> pages = [
    _OnboardPageData(
      image: 'assets/images/features1.png',
      title: 'Clear Case Overview',
      subtitle: 'See status, next hearing, and deadlines at a glance.',
    ),
    _OnboardPageData(
      image: 'assets/images/features2.png',
      title: 'Docs & timelines',
      subtitle: 'Upload documents, preview PDFs, and track every event on an interactive timeline.',
    ),
    _OnboardPageData(
      image: 'assets/images/features3.png',
      title: 'Ask the AI assistant',
      subtitle: 'Get plain-language summaries and quick legal pointers (not legal advice).',
    ),
  ];

  void _nextPage() {
    if (_pageIndex < pages.length - 1) {
      _pageController.animateToPage(
        _pageIndex + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // helper: mark onboarding done then navigate
  Future<void> _finishOnboardingAndNavigate(String routeName) async {
    try {
      final ok = await PreferencesService.setOnboardingDone();
      if (!mounted) return;
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to save preference.')));
        // still navigate to route so user isn't blocked, but you can change that if you want
      }
      Navigator.of(context).pushReplacementNamed(routeName);
    } catch (e) {
      if (!mounted) return;
      // show error but still attempt navigation
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      Navigator.of(context).pushReplacementNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF1D4ED8);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => _pageIndex = i),
              itemBuilder: (context, index) {
                final page = pages[index];
                // pass the active page index (so the indicator highlights correctly)
                return _OnboardPageWidget(
                  data: page,
                  pageIndex: _pageIndex,
                  totalPages: pages.length,
                );
              },
            ),

            // bottom controls (only buttons now)
            Positioned(
              left: 20,
              right: 20,
              bottom: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  if (_pageIndex < pages.length - 1) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Color(0xFF273F9C),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () => _finishOnboardingAndNavigate('/user-selection'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Got It',
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String image;
  final String title;
  final String subtitle;
  _OnboardPageData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardPageWidget extends StatelessWidget {
  final _OnboardPageData data;
  final int pageIndex; // active page index passed from parent
  final int totalPages;

  const _OnboardPageWidget({
    required this.data,
    required this.pageIndex,
    required this.totalPages,
    super.key,
  });

  // functional page indicator (only one control)
  Widget _buildIndicator() {
    return Row(
      children: List.generate(totalPages, (i) {
        final bool active = i == pageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(right: i == totalPages - 1 ? 0 : 8),
          width: active ? 36 : 8,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              data.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade800,
                  child: const Center(
                    child: Icon(Icons.image, size: 72, color: Colors.white24),
                  ),
                );
              },
            ),
          ),

          // indicator ABOVE the title/subtitle; NO dummy decorative control here
          Positioned(
            left: 20,
            right: 20,
            bottom: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildIndicator()),
                const SizedBox(height: 18),
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.92),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
