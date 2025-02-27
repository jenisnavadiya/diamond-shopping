import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kgk/features/cart/screens/cart_button_view.dart';
import 'package:kgk/features/products/cubit/products_cubit.dart';
import 'package:kgk/features/products/widgets/products_list_view.dart';

class ProducstsScreen extends StatefulWidget {
  const ProducstsScreen({super.key});

  @override
  State<ProducstsScreen> createState() => _ProducstsScreenState();
}

class _ProducstsScreenState extends State<ProducstsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Products'),
        actions: [CartButtonView()],
      ),
      body: Column(
        children: [
          SortFilterView(),
          SizedBox(height: 16),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return Expanded(
                  child: ProductsListView(
                      products: state.sortedProducts.isNotEmpty
                          ? state.sortedProducts
                          : state.products));
            },
          ),
        ],
      ),
    );
  }
}

class SortFilterView extends StatefulWidget {
  const SortFilterView({super.key});

  @override
  _SortFilterViewState createState() => _SortFilterViewState();
}

class _SortFilterViewState extends State<SortFilterView> {
  bool? _ascending;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          previous.sortCriteria != current.sortCriteria,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  hint: Text('Sort by'),
                  value: state.sortCriteria,
                  items: [
                    DropdownMenuItem(
                        value: 'price', child: Text('Final Price')),
                    DropdownMenuItem(
                        value: 'carat', child: Text('Carat Weight')),
                  ],
                  onChanged: (value) {
                    context.read<ProductsCubit>().setSortCriteria(value);
                  },
                ),
                SizedBox(width: 16),
                ChoiceChip(
                  label: Text('Asc'),
                  selected: _ascending ?? false,
                  onSelected: (selected) {
                    setState(() {
                      _ascending = true;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text('Desc'),
                  selected: _ascending == null ? false : !_ascending!,
                  onSelected: (selected) {
                    setState(() {
                      _ascending = false;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (state.sortCriteria != null) {
                      context
                          .read<ProductsCubit>()
                          .sortProducts(ascending: _ascending ?? true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please select a sort criteria')),
                      );
                    }
                  },
                  child: Text('Sort'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductsCubit>().clearSorting();
                    _ascending = null;
                    setState(() {});
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
