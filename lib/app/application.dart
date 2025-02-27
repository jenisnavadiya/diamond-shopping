import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/routes/app_routes.dart';
import 'package:kgk/features/cart/cubit/cart_cubit.dart';
import 'package:kgk/features/products/cubit/products_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        )
      ],
      child: MaterialApp.router(
        title: 'KGK Diamond',
        routerConfig: Routes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
