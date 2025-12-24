import 'package:flutter/material.dart';

class LawyerProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;
  const LawyerProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['name']), backgroundColor: const Color(0xFF2D4ED8)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Column(children: [
              CircleAvatar(radius: 46, backgroundImage: NetworkImage(data['avatar'])),
              const SizedBox(height: 12),
              Text(data['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Civil Law', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 6),
                Text('5.0 (12)', style: TextStyle(fontWeight: FontWeight.bold))
              ])
            ]),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Sarah Conor is a highly experienced civil lawyer specializing in contract law, property disputes, and personal injury cases.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 12),
              const Text('Areas of Expertise', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('- Contract Law\n- Property Disputes\n- Personal Injury', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 12),
              const Text('Education', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('- University of California, Riverside\n- University of Miami School of Law', style: TextStyle(color: Colors.black54)),
            ]),
          ),
        ]),
      ),
    );
  }
}