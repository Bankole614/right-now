import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _statisticsCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ]),
      ),
    );
  }

  Widget _quickCard({required Color color, required IconData icon, required String title, required String subtitle}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _appointmentCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2D4ED8), Color(0xFF3F64E6)]),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Mr. Brandon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('Family Lawyer', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.white70),
              const SizedBox(width: 6),
              const Text('July 8, 2025', style: TextStyle(color: Colors.white70)),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14, color: Colors.white70),
              const SizedBox(width: 6),
              const Text('10:30am - 11:30am', style: TextStyle(color: Colors.white70)),
            ])
          ]),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.call, color: Colors.white),
        ),
      ]),
    );
  }

  Widget _recentMessageItem(String name, String text, String timeAgo) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'), radius: 20),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(color: Colors.black54, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
        ])),
        Text(timeAgo, style: const TextStyle(color: Colors.black45, fontSize: 12)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32')),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Hello,', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 4),
                Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ]),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ]),
          const SizedBox(height: 18),

          // Statistics row
          const Text('Statistics', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _statisticsCard('4', 'Active Cases'),
            _statisticsCard('3', 'Unread Messages'),
            // Last item doesn't need right margin; we will wrap a small but keep Expanded
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(children: const [
                  Text('2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Upcoming Hearings', style: TextStyle(color: Colors.black54, fontSize: 12), textAlign: TextAlign.center),
                ]),
              ),
            ),
          ]),
          const SizedBox(height: 18),

          // Today's Appointment
          const Text("Today's Appointment", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _appointmentCard(context),
          const SizedBox(height: 16),

          // Quick actions
          Row(children: [
            _quickCard(color: Colors.orange, icon: Icons.smart_toy, title: 'AI Assistant', subtitle: 'Get instant guidance on your case.'),
            _quickCard(color: Colors.indigo, icon: Icons.search, title: 'Discover', subtitle: 'Search for lawyers willing to take up your cases.'),
          ]),
          const SizedBox(height: 18),

          // Recent Messages
          const Text('Recent Messages', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _recentMessageItem('Jennifer Hudson', 'Please, send me the latest update on the contract.', '2d'),
          _recentMessageItem('Peter Gray', 'Thanks, I received the documents.', '3d'),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }
}
