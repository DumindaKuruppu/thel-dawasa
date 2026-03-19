import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget emailRow() {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'kuruppu.duminda@gmail.com',
    queryParameters: {'subject': 'Hello from Fuel App!'},
  );

  return InkWell(
    onTap: () async {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        debugPrint('Could not launch email app');
      }
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.email, size: 20),
        SizedBox(width: 8),
        Text("kuruppu.duminda@gmail.com"),
      ],
    ),
  );
}
