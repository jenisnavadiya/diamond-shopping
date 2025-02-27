import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/routes/app_routes.dart';
import 'package:kgk/features/cart/cubit/cart_cubit.dart';

class CartButtonView extends StatelessWidget {
  const CartButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_cart,
              ),
              Positioned(
                top: -8,
                right: -2,
                child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      context.read<CartCubit>().getCartCount().toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
          onPressed: () {
            Routes.push(context, Routes.cart);
          },
        );
      },
    );
  }
}
