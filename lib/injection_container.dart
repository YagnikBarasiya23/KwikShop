import 'package:get_it/get_it.dart';
import 'features/cart/domain/usecase/cart_usecase.dart';
import 'features/checkout/data/repository/checkout_repository_impl.dart';
import 'features/home/data/repository/store_repository_impl.dart';
import 'features/home/domain/repository/store_repository.dart';
import 'features/home/domain/usecase/store_usecase.dart';
import 'features/products/data/repository/products_repository_impl.dart';
import 'features/products/domain/usecase/products_usecase.dart';
import 'package:uuid/uuid.dart';
import 'features/cart/data/repository/cart_repository_impl.dart';
import 'features/cart/domain/repository/cart_repository.dart';
import 'features/checkout/domain/repository/checkout_repository.dart';
import 'features/checkout/domain/usecase/checkout_usecase.dart';
import 'features/products/domain/repository/products_repository.dart';

final cartInjection = GetIt.instance;
final checkoutInjection = GetIt.instance;
final storeInjection = GetIt.instance;
final productInjection = GetIt.instance;
final orderId = GetIt.instance;

class DependencyInjection {
  static void initializeDependencies() {
    //-----OrderId-------------
    orderId.registerSingleton<String>(const Uuid().v1());

    //-----Cart-----------------
    cartInjection.registerSingleton<CartRepository>(CartRepositoryImpl());
    cartInjection.registerSingleton<CartUseCase>(CartUseCase(cartInjection()));

    //-----Checkout--------------
    checkoutInjection
        .registerSingleton<CheckoutRepository>(CheckoutRepositoryImpl());
    checkoutInjection.registerSingleton<CheckoutOrderDetailsUseCase>(
        CheckoutOrderDetailsUseCase(cartInjection()));
    checkoutInjection.registerSingleton<CheckoutLocationDetailsUseCase>(
        CheckoutLocationDetailsUseCase(cartInjection()));

    //-----Store----------------
    storeInjection.registerSingleton<StoreRepository>(StoreRepositoryImpl());
    storeInjection
        .registerSingleton<StoreUseCase>(StoreUseCase(storeInjection()));

    //-----Products-------------------
    productInjection
        .registerSingleton<ProductsRepository>(ProductsRepositoryImpl());
    productInjection.registerSingleton<ProductsUseCase>(
        ProductsUseCase(productInjection()));
  }
}
