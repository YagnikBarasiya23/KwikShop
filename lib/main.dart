import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/features/cart/presentation/bloc/orderid_cubit.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_colors.dart';
import 'config/theme/app_theme.dart';
import 'features/authentication/presentation/bloc/checkbox_cubit.dart';
import 'features/authentication/presentation/bloc/visibility_cubit.dart';
import 'features/bookmark/bloc/bookmark_cubit.dart';
import 'features/cart/presentation/bloc/cart_cubit.dart';
import 'features/products/presentation/bloc/current_category_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

Future<void> main() async {
  ErrorWidget.builder = (_) => const SizedBox();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  DependencyInjection.initializeDependencies();
  runApp(
    const _KwiKShop(),
  );
}

class _KwiKShop extends StatelessWidget {
  const _KwiKShop();
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => BookmarkCubit(),
          ),
          BlocProvider(
            create: (_) => CartCubit(),
          ),
          BlocProvider(
            create: (_) => VisibilityCubit(),
          ),
          BlocProvider(
            create: (_) => CheckboxCubit(),
          ),
          BlocProvider(
            create: (_) => CurrentCategoryCubit(),
          ),
          BlocProvider(
            create: (_) => OrderIdCubit(),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoutes,
          theme: ThemeHelper.lightTheme(AppColors.primaryAppColor),
          debugShowCheckedModeBanner: false,
        ),
      );
}
