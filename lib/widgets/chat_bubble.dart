import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chat_bubble extends StatelessWidget {
  final String message;
  const chat_bubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFf6a806),
      ),
        child: Text(
            message,
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
    );
  }
}
