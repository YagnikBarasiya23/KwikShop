import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderIdCubit extends Cubit<List<String>> {
  static SharedPreferences? _orderIdPreferences;

  static const orderIdKey = 'orderIdKey';

  OrderIdCubit() : super([]) {
    init();
  }

  Future init() async {
    _orderIdPreferences = await SharedPreferences.getInstance();
    final List<String> orderIds =
        _orderIdPreferences!.getStringList(orderIdKey) ?? [];
    emit(orderIds);
  }

  Future setOrderId(String orderId) async {
    _orderIdPreferences = await SharedPreferences.getInstance();
    state.add(orderId);
    emit(state);
    await _orderIdPreferences!.setStringList(orderIdKey, state);
  }
}
