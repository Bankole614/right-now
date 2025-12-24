import 'package:flutter/material.dart';
import 'package:right_now/screens/widgets/lawyer_card.dart';

import 'lawyer_profile.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> lawyers = List.generate(6, (i) {
    return {
      'name': 'Sarah Conor',
      'specialty': 'Family law',
      'experience': '${6 + i} years experience',
      'rating': 5,
      'reviews': 12 + i,
      'avatar': 'https://i.pravatar.cc/150?img=${20 + i}',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D4ED8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          // Search
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.search, color: Colors.black38),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search by name, specialization, or location',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),

          // Filters as chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _filterChip('All'),
                _filterChip('Location'),
                _filterChip('Rating'),
                _filterChip('Fee'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Results list
          Expanded(
            child: ListView.builder(
              itemCount: lawyers.length,
              itemBuilder: (context, index) {
                final item = lawyers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: LawyerCard(
                    name: item['name'],
                    specialty: item['specialty'],
                    experience: item['experience'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                    avatarUrl: item['avatar'],
                    onBook: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LawyerProfilePage(data: item)));
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _filterChip(String label) {
    final selected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _selectedFilter = label),
        selectedColor: Colors.indigo,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
      ),
    );
  }
}