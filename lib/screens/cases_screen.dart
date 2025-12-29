import 'package:flutter/material.dart';
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
      'title': 'Food Co. vs Jane',
      'client': 'Jane Smith',
      'type': 'Contract dispute',
      'status': 'Pending',
      'hearing': 'Next Hearing: Nov 20 · Courtroom B',
      'progress': 0.15,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                              hintStyle: const TextStyle(color: Colors.black38),
                              filled: true,
                              fillColor: const Color(0xFFF3F4F6),
                              contentPadding: const EdgeInsets.only(
                                left: 48, // Space for the icon
                                right: 16,
                                top: 14,
                                bottom: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF2D4ED8), // Border color on focus
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // Positioned Search Icon
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Icon(Icons.search, color: Colors.black38, size: 22),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Filter Button
                    InkWell(
                      onTap: () {
                        _showFilterDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.tune, size: 22, color: Colors.black54),
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
                      _buildStatCard('4', 'Active Cases'),
                      const SizedBox(width: 8),
                      _buildStatCard('3', 'Unread Messages'),
                      const SizedBox(width: 8),
                      _buildStatCard('2', 'Upcoming Hearings'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cases List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final caseItem = cases[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCaseCard(caseItem),
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
        backgroundColor: Constants.kPrimaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseItem) {
    // Define colors based on status
    final bool isPending = caseItem['status'] == 'Pending';
    final Color statusColor = isPending ? Colors.orange.shade800 : const Color(0xFF2D4ED8);
    final Color statusBackgroundColor = isPending ? Colors.orange.withOpacity(0.1) : const Color(0xFF2D4ED8).withOpacity(0.1);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryBlue),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),

          // Header with title and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  caseItem['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBackgroundColor, // Use the dynamic background color
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
            style: const TextStyle(
              color: Colors.black54,
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
                  color: const Color(0xFF2D4ED8).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      caseItem['hearing'],
                      style: const TextStyle(
                        color: kPrimaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
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
    );
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                      const Text(
                        'Filter Cases',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChipModal('All', setModalState),
                      _filterChipModal('Active', setModalState),
                      _filterChipModal('Pending', setModalState),
                      _filterChipModal('Closed', setModalState),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Case Type',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChipModal('Contract', setModalState),
                      _filterChipModal('Property', setModalState),
                      _filterChipModal('Family', setModalState),
                      _filterChipModal('Criminal', setModalState),
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
                            side: const BorderSide(color: Color(0xFF2D4ED8)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: Color(0xFF2D4ED8),
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
                            backgroundColor: const Color(0xFF2D4ED8),
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

  // Helper method for filter chips in the modal
  Widget _filterChipModal(String label, StateSetter setModalState) {
    // This logic might need to be adjusted based on how you want to handle filter selections
    // For now, it uses the same _selectedFilter variable
    final selected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setModalState(() {
          _selectedFilter = label;
        });
        // Also update the main screen's state
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2D4ED8) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
