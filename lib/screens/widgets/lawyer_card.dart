import 'package:flutter/material.dart';

class LawyerCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String experience;
  final int rating;
  final int reviews;
  final String avatarUrl;
  final VoidCallback onBook;

  const LawyerCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.avatarUrl,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        CircleAvatar(radius: 28, backgroundImage: NetworkImage(avatarUrl)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('$specialty · $experience', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Row(children: [
              Row(
                children: List.generate(rating, (i) => const Icon(Icons.star, size: 16, color: Colors.amber)),
              ),
              const SizedBox(width: 6),
              Text('(\$reviews)', style: const TextStyle(color: Colors.black45)),
            ])
          ]),
        ),
        ElevatedButton(
          onPressed: onBook,
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
          child: const Text('Book Consultation'),
        ),
      ]),
    );
  }
}