import 'package:flutter/material.dart';
import 'package:right_now/screens/case_details_screen.dart';
import 'package:right_now/screens/create_case_screen.dart';
import 'package:right_now/utils/constants.dart';

class CasesScreen extends StatefulWidget {
  const CasesScreen({super.key});

  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  // Dummy data for cases
  final List<Map<String, dynamic>> cases = [
    {
      'title': 'John vs Nigerian Govt.',
      'client': 'John Smith',
      'type': 'Contract dispute',
      'status': 'Active',
      'hearing': 'Next Hearing: Nov 20 · Courtroom B',
      'progress': 0.75,
    },
    {
      'title': 'Food Co. vs Jane',
      'client': 'Jane Smith',
      'type': 'Contract dispute',
      'status': 'Pending',
      'hearing': 'Next Hearing: Nov 20 · Courtroom B',
      'progress': 0.35,
    },
    {
      'title': 'Property Damage Claim',
      'client': 'Alice Johnson',
      'type': 'Tort Law',
      'status': 'Active',
      'hearing': 'Next Hearing: Dec 5 · Courtroom A',
      'progress': 0.50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cases',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search cases',
                              hintStyle: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.black38,
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : const Color(0xFFF3F4F6),
                              contentPadding: const EdgeInsets.only(
                                left: 48,
                                right: 16,
                                top: 14,
                                bottom: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark ? Colors.grey[700]! : Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: kPrimaryBlue,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          // Positioned Search Icon
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(
                                Icons.search,
                                color: isDark ? Colors.grey[400] : Colors.black38,
                                size: 22
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Filter Button
                    InkWell(
                      onTap: () {
                        _showFilterDialog(context, isDark);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? Colors.grey[700]! : Colors.grey.shade400,
                          ),
                        ),
                        child: Icon(
                            Icons.tune,
                            size: 22,
                            color: isDark ? Colors.grey[400] : Colors.black54
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Statistics Row
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStatCard('4', 'Active Cases', isDark),
                      const SizedBox(width: 8),
                      _buildStatCard('3', 'Unread Messages', isDark),
                      const SizedBox(width: 8),
                      _buildStatCard('2', 'Upcoming Hearings', isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cases List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Modified padding
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final caseItem = cases[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  // MODIFICATION: Pass context to the build method
                  child: _buildCaseCard(context, caseItem, isDark),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateCaseScreen()),
          );
        },
        backgroundColor: kPrimaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Color(0xFF343434),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // MODIFICATION: Wrapped card in InkWell, added navigation logic, and accepted BuildContext
  Widget _buildCaseCard(BuildContext context, Map<String, dynamic> caseItem, bool isDark) {
    // Define colors based on status
    final bool isPending = caseItem['status'] == 'Pending';
    final Color statusColor = isPending
        ? (isDark ? Colors.orange[300]! : Colors.orange.shade800)
        : kPrimaryBlue;

    final Color statusBackgroundColor = isPending
        ? (isDark ? Colors.orange.withOpacity(0.2) : Colors.orange.withOpacity(0.1))
        : kPrimaryBlue.withOpacity(isDark ? 0.2 : 0.1);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CaseDetailsScreen(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on: ${caseItem['title']}')),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: caseItem['progress'],
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryBlue),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    caseItem['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    caseItem['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Client info
            Text(
              'Client: ${caseItem['client']} · ${caseItem['type']}',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.black54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: kPrimaryBlue.withOpacity(isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        caseItem['hearing'],
                        style: TextStyle(
                          color: isDark ? Colors.blue[200] : kPrimaryBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // This icon is purely decorative now since the whole card is tappable
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: const Icon(Icons.chevron_right, size: 24, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Cases',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: isDark ? Colors.grey[400] : Colors.black54,
                        ),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChipModal('All', setModalState, isDark),
                      _filterChipModal('Active', setModalState, isDark),
                      _filterChipModal('Pending', setModalState, isDark),
                      _filterChipModal('Closed', setModalState, isDark),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Case Type',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChipModal('Contract', setModalState, isDark),
                      _filterChipModal('Property', setModalState, isDark),
                      _filterChipModal('Family', setModalState, isDark),
                      _filterChipModal('Criminal', setModalState, isDark),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() => _selectedFilter = 'All');
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kPrimaryBlue),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: kPrimaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _filterChipModal(String label, StateSetter setModalState, bool isDark) {
    final selected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setModalState(() {
          _selectedFilter = label;
        });
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? kPrimaryBlue
              : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : (isDark ? Colors.grey[300] : Colors.black87),
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
