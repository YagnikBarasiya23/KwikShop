import 'package:flutter/material.dart';
import 'package:kwikshop/features/profile/presentation/widgets/profile_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Uri url = Uri.parse(
                  'https://pages.flycricket.io/kwikshop/privacy.html',
                );
                launchUrl(url);
              },
              child: const Card(
                child: ProfileTile(
                  title: 'Privacy Policy',
                  icon: Icons.lock,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Uri url = Uri.parse(
                  'https://pages.flycricket.io/kwikshop/terms.html',
                );
                launchUrl(url);
              },
              child: const Card(
                child: ProfileTile(
                  title: 'Terms and Conditions',
                  icon: Icons.verified_user_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
