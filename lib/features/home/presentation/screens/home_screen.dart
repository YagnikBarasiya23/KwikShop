import 'package:flutter/material.dart';
import 'package:kwikshop/assets_gen.dart';
import 'package:kwikshop/features/bookmark/presentation/screens/bookmark_screen.dart';
import 'package:kwikshop/features/categories/domain/entities.dart';
import 'package:kwikshop/features/categories/presentation/screens/categories_screen.dart';
import 'package:kwikshop/features/home/domain/usecase/store_usecase.dart';
import 'package:kwikshop/features/profile/presentation/screens/profile_screen.dart';
import 'package:kwikshop/injection_container.dart';
import '../../domain/entities/store.dart';
import '../widgets/offers_widget.dart';
import '../widgets/store_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<Store> stores =
        storeInjection.get<StoreUseCase>().call(params: Categories.all);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Assets.icons.kwikshopLabelIcon.image(
          width: screenWidth * 0.4,
          height: 40,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, CategoriesScreen.routeName),
            icon: const Icon(
              Icons.grid_view_rounded,
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, BookMarkScreen.routeName),
            icon: const Icon(
              Icons.bookmark_rounded,
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: const ProfileScreen(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hey! ',
                      style: textTheme.titleSmall!
                          .copyWith(color: Colors.amber.shade800),
                    ),
                    TextSpan(
                      text:
                          "It's time to shop your daily groceries from your nearby retailers",
                      style: textTheme.titleSmall,
                    ),
                  ],
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Offers&Benefits',
                style: textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 5),
            const OffersWidget(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Best Retailers Nearby',
                style: textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final Store store = stores[index];
                  return StoreCard(store: store);
                },
                itemCount: stores.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemExtent: 250,
              ),
            )
          ],
        ),
      ),
    );
  }
}
