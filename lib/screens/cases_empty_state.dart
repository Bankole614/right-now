import 'package:flutter/material.dart';

class CasesEmptyState extends StatelessWidget {
  const CasesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Cases',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D4ED8),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Empty folder icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -2,
                    left: 8,
                    child: Container(
                      width: 35,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 2.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        color: const Color(0xFFF3F4F6),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 30,
                    bottom: 25,
                    child: Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'No Cases Yet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'You haven\'t created any case yet.\nStart by adding a new case so you can track progress easily.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Create button
              ElevatedButton(
                onPressed: () {
                  // Navigate to create case screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const CreateCaseScreen()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4ED8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Create a New Case',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Help text
              const Text(
                'Need help? Try asking the AI for legal guidance.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}