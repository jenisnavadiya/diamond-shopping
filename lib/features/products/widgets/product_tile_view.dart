import 'package:flutter/material.dart';
import 'package:kgk/features/products/models/product_model.dart';

class ProductItemTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;
  final bool isAddedToCart;

  const ProductItemTile({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    this.isAddedToCart = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRowView('Lot ID:', product.lotId.toString()),
            DetailRowView('Size:', product.size ?? 'N/A'),
            DetailRowView('Carat:', product.carat?.toStringAsFixed(2) ?? 'N/A'),
            DetailRowView('Lab:', product.lab ?? 'N/A'),
            DetailRowView('Shape:', product.shape ?? 'N/A'),
            DetailRowView('Color:', product.color ?? 'N/A'),
            DetailRowView('Clarity:', product.clarity ?? 'N/A'),
            DetailRowView('Cut:', product.cut ?? 'N/A'),
            DetailRowView('Polish:', product.polish ?? 'N/A'),
            DetailRowView('Symmetry:', product.symmetry ?? 'N/A'),
            DetailRowView('Fluorescence:', product.fluorescence ?? 'N/A'),
            DetailRowView('Discount:',
                '${product.discount?.toStringAsFixed(2) ?? 'N/A'}%'),
            DetailRowView('Per Carat Rate:',
                '₹ ${product.perCaratRate?.toStringAsFixed(2) ?? 'N/A'}'),
            DetailRowView('Final Amount:',
                '₹ ${product.finalAmount?.toStringAsFixed(2) ?? 'N/A'}'),
            DetailRowView('Key To Symbol:', product.keyToSymbol ?? 'N/A'),
            DetailRowView('Lab Comment:', product.labComment ?? 'N/A'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isAddedToCart) ...{
                  ElevatedButton(
                    onPressed: onAddToCart,
                    child: Text('Add to cart'),
                  ),
                } else ...{
                  ElevatedButton(
                    onPressed: onRemoveFromCart,
                    child: Text('Remove from cart'),
                  ),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRowView extends StatelessWidget {
  final String title;
  final String value;
  const DetailRowView(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
