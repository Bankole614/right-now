import 'package:flutter/material.dart';
import 'package:right_now/screens/widgets/consultation_modal.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here
import 'lawyer_profile.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  // Dummy data for lawyers
  final List<Map<String, dynamic>> lawyers = List.generate(6, (i) {
    return {
      'name': 'Sarah Conor',
      'specialty': 'Family law',
      'experience': '8 years experience',
      'rating': 5,
      'reviews': 12,
      'avatar': 'https://i.pravatar.cc/150?img=${20 + i}',
    };
  });

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    isDark ? const Color(0xFF121212) : const Color(0xFFF3F4F6);
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
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
          // --- MODIFICATION: Search and Filter Section Card ---
          Container(
            color: cardBackgroundColor,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                // Styled Search Bar
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Search by name, specialization, or location',
                    hintStyle: TextStyle(color: subTextColor, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: subTextColor, size: 22),
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF2C2C2E)
                        : const Color(0xFFF3F4F6),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter chips
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _filterChip('All', isDark),
                      _filterChip('Location', isDark),
                      _filterChip('Rating', isDark),
                      _filterChip('Fee', isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // --- MODIFICATION: Lawyers list with spacing ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: lawyers.length,
              itemBuilder: (context, index) {
                final lawyer = lawyers[index];
                return _lawyerCard(
                  context,
                  lawyer,
                  isDark,
                  cardBackgroundColor,
                  textColor,
                  subTextColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isDark) {
    final selected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _selectedFilter = label),
        selectedColor: kPrimaryBlue,
        backgroundColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
        labelStyle: TextStyle(
          color: selected
              ? Colors.white
              : (isDark ? Colors.grey[300] : Colors.black87),
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          side: selected
              ? BorderSide.none
              : BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        showCheckmark: false,
      ),
    );
  }

  Widget _lawyerCard(
      BuildContext context,
      Map<String, dynamic> data,
      bool isDark,
      Color cardBackgroundColor,
      Color textColor,
      Color subTextColor,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LawyerProfilePage(data: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark
              ? null
              : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(data['avatar']),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${data['specialty']} · ${data['experience']}',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ...List.generate(
                            data['rating'],
                                (i) => const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${data['reviews']})',
                            style: TextStyle(
                              color: subTextColor.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showConsultationModal(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0, // No shadow needed for the button
                ),
                child: const Text(
                  'Book Consultation',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
