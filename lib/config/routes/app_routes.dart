import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwikshop/core/shared/app_loading.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/registration_screen.dart';
import '../../features/authentication/presentation/screens/reset_password_screen.dart';
import '../../features/bookmark/presentation/screens/bookmark_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/categories/domain/entities.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/categories/presentation/screens/catergory_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/profile/presentation/screens/about_us_screen.dart';
import '../../features/profile/presentation/screens/addresses_screen.dart';
import '../../features/profile/presentation/screens/feedback_screen.dart';
import '../../features/profile/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/welcome/presentation/screens/welcome_screen.dart';

class RouteGenerator {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoading();
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const WelcomeScreen();
              }
            },
          ),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RegistrationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreen(),
        );
      case ResetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case CategoriesScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
      case CategoryScreen.routeName:
        final category = settings.arguments as Categories;
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        );
      case BookMarkScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const BookMarkScreen(),
        );

      case ProductScreen.routeName:
        final storeName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductScreen(
            storeName: storeName,
          ),
        );
      case CartScreen.routeName:
        final storeName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CartScreen(
            storeName: storeName,
          ),
        );
      case CheckoutScreen.routeName:
        final args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(
            storeName: args[0],
            grandTotal: args[1],
          ),
        );
      case AboutUsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const AboutUsScreen(),
        );
      case AddressScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const AddressScreen(),
        );
      case FeedBackScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const FeedBackScreen(),
        );
      case OrdersScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const OrdersScreen(),
        );
      case AccountSettingScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const AccountSettingScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }
}
