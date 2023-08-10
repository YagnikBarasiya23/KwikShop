import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/core/shared/app_cached_network_image.dart';
import 'package:kwikshop/features/bookmark/bloc/bookmark_cubit.dart';
import 'package:kwikshop/features/products/presentation/screens/products_screen.dart';
import '../../domain/entities/store.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.store});
  final Store store;
  static Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    if (store.storeRating >= 4.0) {
      color = const Color(0xff2FB47A);
    } else {
      color = const Color(0xffDB805E);
    }
    final bool isBookmark =
        context.watch<BookmarkCubit>().state.contains(store.id);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductScreen.routeName,
        arguments: store.storeName,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: screenWidth,
          height: 230,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: CachedImage(
                      imageUrl: store.storeImage,
                      height: 149,
                      width: screenWidth,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 15, bottom: 5),
                    child: Text(
                      store.storeName,
                      style: textTheme.titleMedium!.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.store_mall_directory_outlined,
                          color: Colors.orange,
                        ),
                        Text(
                          store.storeType,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 6, right: 3),
                          child: Icon(
                            Icons.circle,
                            color: Colors.grey,
                            size: 7,
                          ),
                        ),
                        const Icon(
                          Icons.pin_drop,
                          color: Colors.orange,
                        ),
                        Expanded(
                          child: Text(
                            store.storeAddress,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: color,
                      child: Text(
                        store.storeRating.toString(),
                        style: textTheme.titleSmall,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () => context
                            .read<BookmarkCubit>()
                            .toggleBookmark(store.id),
                        icon: Icon(
                          isBookmark ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
