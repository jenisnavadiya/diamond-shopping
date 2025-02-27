import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/data/products_data.dart';
import 'package:kgk/core/routes/app_routes.dart';
import 'package:kgk/features/cart/cubit/cart_cubit.dart';
import 'package:kgk/features/cart/screens/cart_button_view.dart';
import 'package:kgk/features/products/cubit/products_cubit.dart';
import 'package:kgk/features/products/models/filter_model.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromCaratController = TextEditingController();
  final TextEditingController _toCaratController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fromCaratController.text =
          context.read<ProductsCubit>().state.filter.fromCarat?.toString() ??
              '';
      _toCaratController.text =
          context.read<ProductsCubit>().state.filter.toCarat?.toString() ?? '';
      context.read<CartCubit>().getCartItems();
      setState(() {});
    });
    super.initState();
  }

  void onChangeDropDown(BuildContext context, FilterModel filter) {
    context.read<ProductsCubit>().selectFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KGK Diamond'),
        actions: [
          CartButtonView(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Carat Range"),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _fromCaratController,
                            decoration: InputDecoration(
                              labelText: 'From',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              final minValue = KGKProducts.getMinMaxCarat().$1;
                              final maxValue = KGKProducts.getMinMaxCarat().$2;
        
                              if (value != null &&
                                  double.tryParse(value) != null) {
                                final carat = double.parse(value);
                                if (carat < minValue || carat > maxValue) {
                                  return 'Carat should be between $minValue and $maxValue';
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _toCaratController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'To',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              final maxValue = KGKProducts.getMinMaxCarat().$2;
        
                              if (_fromCaratController.text.isNotEmpty &&
                                  (value ?? '').isEmpty) {
                                return 'Please enter end carat range';
                              }
        
                              if ((value ?? '').isNotEmpty &&
                                  double.tryParse(value ?? '') != null) {
                                final carat = double.parse(value ?? '');
                                if (carat <=
                                        double.parse(_fromCaratController.text) ||
                                    carat > maxValue) {
                                  return 'Carat range should be greater than start carat range and less than $maxValue';
                                }
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    DropdownSearch<String>(
                      items: (f, cs) => KGKProducts.productLabs,
                      selectedItem: state.filter.lab,
                      onChanged: (value) {
                        onChangeDropDown(
                          context,
                          state.filter.copyWith(lab: value),
                        );
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Lab',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownSearch<String>(
                      items: (f, cs) => KGKProducts.productShapes,
                      selectedItem: state.filter.shape,
                      popupProps: PopupProps.menu(showSearchBox: true),
                      onChanged: (value) {
                        onChangeDropDown(
                          context,
                          state.filter.copyWith(shape: value),
                        );
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Shape',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownSearch<String>(
                      items: (f, cs) => KGKProducts.productColors,
                      selectedItem: state.filter.color,
                      popupProps: PopupProps.menu(showSearchBox: true),
                      onChanged: (value) {
                        onChangeDropDown(
                          context,
                          state.filter.copyWith(color: value),
                        );
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Color',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownSearch<String>(
                      items: (f, cs) => KGKProducts.productClarity,
                      selectedItem: state.filter.clarity,
                      popupProps: PopupProps.menu(showSearchBox: true),
                      onChanged: (value) {
                        onChangeDropDown(
                          context,
                          state.filter.copyWith(clarity: value),
                        );
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Clarity',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            onChangeDropDown(
                                context,
                                state.filter.copyWith(
                                  fromCarat:
                                      double.tryParse(_fromCaratController.text),
                                  toCarat:
                                      double.tryParse(_toCaratController.text),
                                ));
        
                            if ((_fromCaratController.text.isNotEmpty &&
                                _toCaratController.text.isNotEmpty )||
                                state.filter.lab != null ||
                                state.filter.shape != null ||
                                state.filter.color != null ||
                                state.filter.clarity != null) {
                              Routes.push(context, Routes.products);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Please select at least one filter')),
                              );
                            }
                          },
                          child: Text('Apply Filters'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _fromCaratController.clear();
                            _toCaratController.clear();
                            onChangeDropDown(context, FilterModel());
                            setState(() {});
                          },
                          child: Text('Clear Filters'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
