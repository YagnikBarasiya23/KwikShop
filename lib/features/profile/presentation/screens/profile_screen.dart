import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/core/shared/app_loading.dart';
import 'package:kwikshop/features/profile/presentation/screens/about_us_screen.dart';
import 'package:kwikshop/features/profile/presentation/screens/addresses_screen.dart';
import 'package:kwikshop/features/profile/presentation/screens/feedback_screen.dart';
import 'package:kwikshop/features/profile/presentation/screens/orders_screen.dart';
import 'package:kwikshop/features/profile/presentation/screens/settings_screen.dart';

import '../widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static final Stream<DocumentSnapshot<Map<String, dynamic>>> _stream =
      FirebaseFirestore.instance
          .collection('ProfileDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('UserDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _stream,
      builder: (context, snapshot) {
        final String firstName = snapshot.data!['FirstName'];
        final String lastName = snapshot.data!['LastName'];
        final String emailId = FirebaseAuth.instance.currentUser!.email!;
        return Drawer(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: snapshot.data == null
              ? const AppLoading()
              : Column(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        "$firstName $lastName",
                        style: textTheme.titleLarge!.copyWith(
                          color: colorScheme.surface,
                        ),
                      ),
                      accountEmail: Text(emailId),
                      currentAccountPicture: const CircleAvatar(
                        child: Icon(Icons.person, size: 35),
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Tile.tiles[index].routeName,
                        ),
                        child: ProfileTile(
                          icon: Tile.tiles[index].icon,
                          title: Tile.tiles[index].title,
                        ),
                      ),
                      itemCount: Tile.tiles.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (__, _) => const Divider(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class Tile {
  final String title;
  final IconData icon;
  final String routeName;
  const Tile(
      {required this.icon, required this.title, required this.routeName});

  static const List<Tile> tiles = [
    Tile(
      icon: Icons.shopping_bag,
      title: 'My Orders',
      routeName: OrdersScreen.routeName,
    ),
    Tile(
      icon: Icons.location_city,
      title: 'Addresses',
      routeName: AddressScreen.routeName,
    ),
    Tile(
      icon: Icons.settings,
      title: "Account Settings",
      routeName: AccountSettingScreen.routeName,
    ),
    Tile(
      icon: Icons.feedback,
      title: "Feedback",
      routeName: FeedBackScreen.routeName,
    ),
    Tile(
      icon: Icons.info,
      title: "About Us",
      routeName: AboutUsScreen.routeName,
    ),
  ];
}
