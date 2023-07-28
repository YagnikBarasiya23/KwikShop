import 'package:kwikshop/core/usecase/usecase.dart';
import 'package:kwikshop/features/categories/domain/entities.dart';
import 'package:kwikshop/features/home/domain/repository/store_repository.dart';

import '../entities/store.dart';

class StoreUseCase implements UseCase<List<Store>, Categories> {
  final StoreRepository _storeRepository;
  const StoreUseCase(this._storeRepository);
  @override
  List<Store> call({required Categories params}) =>
      _storeRepository.loadAllStores(params);
}
