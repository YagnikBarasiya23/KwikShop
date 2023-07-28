import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkCubit extends Cubit<List<String>> {
  SharedPreferences? _sharedPreferences;
  static const String bookmarkKey = 'bookmark';
  BookmarkCubit() : super([]) {
    initializePreferences();
  }

  void initializePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final bookmarkStores = _sharedPreferences!.getStringList(bookmarkKey);
    emit(bookmarkStores!);
  }

  Future<void> toggleBookmark(String storeId) async {
    final List<String> updatedStores = List.from(state);
    if (updatedStores.contains(storeId)) {
      updatedStores.remove(storeId);
    } else {
      updatedStores.add(storeId);
    }
    emit(updatedStores);
    await _sharedPreferences!.setStringList(bookmarkKey, updatedStores);
  }
}
