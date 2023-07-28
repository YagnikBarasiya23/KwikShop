import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../categories/domain/entities.dart';
import '../../../home/domain/entities/store.dart';
import '../../../home/domain/usecase/store_usecase.dart';
import '../../../home/presentation/widgets/store_card.dart';
import '../../bloc/bookmark_cubit.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});
  static const routeName = '/bookmark';
  static final stores =
      storeInjection.get<StoreUseCase>().call(params: Categories.all);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: BlocBuilder<BookmarkCubit, List<String>>(
        builder: (context, state) => state.isEmpty
            ? const Center(
                child: Text("Nothing to show"),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final List<String> bookmarked = state;
                      final List<Store> bookmarkStores = stores
                          .where(
                            (store) => bookmarked.contains(
                              store.id,
                            ),
                          )
                          .toList();

                      return StoreCard(store: bookmarkStores[index]);
                    },
                    shrinkWrap: true,
                    itemCount: state.length,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
      ),
    );
  }
}
