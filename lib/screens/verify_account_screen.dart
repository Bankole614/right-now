import 'dart:async'; // Import the async library for the Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
        (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
        (index) => FocusNode(),
  );

  // --- Start of new code for the timer ---
  late Timer _timer;
  int _start = 60; // Countdown duration in seconds
  bool _isTimerRunning = false;

  void startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isTimerRunning = false;
            _start = 60; // Reset for next time
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the screen loads
  }
  // --- End of new code for the timer ---

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer.cancel(); // Make sure to cancel the timer to avoid memory leaks
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/gavel.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Verify your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                        text:
                        'Please enter the Verification code sent to\n'),
                    TextSpan(
                      text: 'work@example.com',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(text: ' to proceed'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(text: 'Not your mail? '),
                    TextSpan(
                      text: 'Edit here',
                      style: TextStyle(
                        color: Color(0xFF3F51B5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                      (index) => _buildOTPBox(index),
                ),
              ),
              const SizedBox(height: 24),
              // --- Updated RichText for the countdown timer ---
              GestureDetector(
                onTap: _isTimerRunning ? null : () {
                  // This will only be tappable when the timer is not running
                  print("Resending code..."); // Add your resend logic here
                  startTimer();
                },
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    children: [
                      const TextSpan(text: 'Didn\'t receive code? '),
                      TextSpan(
                        text: _isTimerRunning ? 'Resend in ${_start}s' : 'Resend',
                        style: TextStyle(
                          color: _isTimerRunning ? Colors.grey : const Color(0xFF3F51B5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }
}
