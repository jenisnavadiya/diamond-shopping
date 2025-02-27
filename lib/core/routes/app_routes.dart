import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kgk/features/cart/screens/cart_screen.dart';
import 'package:kgk/features/products/screens/filters_screen.dart';
import 'package:kgk/features/products/screens/products_screen.dart';
import 'package:kgk/features/splash/screen/splash_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String filters = '/filters';
  static const String products = '/products';
  static const String cart = '/cart';

  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      transitionGoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) {
          return const SplashScreen();
        },
      ),
      transitionGoRoute(
        path: Routes.filters,
        pageBuilder: (context, state) {
          return const FiltersScreen();
        },
      ),
      transitionGoRoute(
        path: Routes.products,
        pageBuilder: (context, state) {
          return const ProducstsScreen();
        },
      ),
      transitionGoRoute(
        path: Routes.cart,
        pageBuilder: (context, state) {
          return const CartScreen();
        },
      ),
    ],
  );

  static Future push<T>(BuildContext context, String page,
      {T? arguments}) async {
    return await context.push(page, extra: arguments);
  }

  static void replace<T>(BuildContext context, String page,
      {T? arguments}) async {
    context.replace(page, extra: arguments);
  }

  static void go<T>(BuildContext context, String page, {T? arguments}) {
    context.go(page, extra: arguments);
  }
}

GoRoute transitionGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => 
    MaterialPage(
      key: state.pageKey,
      child: pageBuilder(context, state),
    ),
  );
}
