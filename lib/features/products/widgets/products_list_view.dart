import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/features/cart/cubit/cart_cubit.dart';
import 'package:kgk/features/products/models/product_model.dart';
import 'package:kgk/features/products/widgets/product_tile_view.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      shrinkWrap: true,
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return ProductItemTile(
              product: products[index],
              onAddToCart: () {
                context.read<CartCubit>().addToCart(products[index]);
              },
              onRemoveFromCart: () {
                context.read<CartCubit>().removeFromCart(products[index]);
              },
              isAddedToCart:
                  context.read<CartCubit>().isProductInCart(products[index]),
            );
          },
        );
      },
    );
  }
}
