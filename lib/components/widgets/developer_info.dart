import 'package:flutter/material.dart';

import 'email_row.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Developer Info',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.person, size: 20),
            SizedBox(width: 8),
            Text("Duminda Kuruppu"),
          ],
        ),
        const SizedBox(height: 4),
        emailRow(),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.code, size: 20),
            const SizedBox(width: 8),
            Text('version 1.0.0'),
          ],
        ),
      ],
    );
  }
}
