import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/utils/colours.dart';

class PrivacyScreenPage extends ConsumerWidget {
  const PrivacyScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: purpleBackgroundColor,
      appBar: AppBar(
        title: const Text("Privacy"),
        centerTitle: true,
        backgroundColor: purpleBackgroundColor,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Text(
            """Privacy Policy for ommyfitness

At ommyfitness, we respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose information when you use our mobile application (the "App").

Collection of Information

We do not collect any data except for the email and delivery address provided by users themselves. This information is necessary to provide you with the physical services and payment processing via mobile money.

Use of Information

The information we collect is used only for the purpose of providing you with the services you have requested, such as delivering automotive spare parts to the delivery address you have provided, and processing payments via mobile money. We do not share your information with any third parties for marketing purposes.

We may use your email address to communicate with you about your orders or to send you marketing communications if you have opted-in to receive them.

Data Security

We take reasonable steps to protect your personal information from unauthorized access, use, or disclosure. We have implemented appropriate physical, electronic, and managerial procedures to safeguard and secure the information we collect.

However, please be aware that no method of transmission over the Internet or electronic storage is completely secure, and we cannot guarantee absolute security of your personal information.

Changes to this Policy

We may update this Privacy Policy from time to time. Any changes we make will be posted on this page. Your continued use of the App after we make changes is deemed to be acceptance of those changes.

Contact Us

If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at admin@ommyfitness.com.""",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
