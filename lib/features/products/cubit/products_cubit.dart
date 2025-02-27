import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kgk/core/data/products_data.dart';
import 'package:kgk/features/products/models/filter_model.dart';
import 'package:kgk/features/products/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsState());

  void selectFilter(FilterModel filter) {
    emit(state.copyWith(filter: filter));
  }

  void getProducts() {
    emit(state.copyWith(getProductsStatus: FormzSubmissionStatus.inProgress));
    final filteredProducts = KGKProducts.products.where((product) {
      final filter = state.filter;
      bool matches = true;

      if (filter.lab != null && filter.lab!.isNotEmpty) {
        matches = matches && product.lab == filter.lab;
      }
      if (filter.clarity != null && filter.clarity!.isNotEmpty) {
        matches = matches && product.clarity == filter.clarity;
      }
      if (filter.color != null && filter.color!.isNotEmpty) {
        matches = matches && product.color == filter.color;
      }
      if (filter.shape != null && filter.shape!.isNotEmpty) {
        matches = matches && product.shape == filter.shape;
      }
      if (filter.fromCarat != null) {
        matches = matches && (product.carat ?? 0) >= filter.fromCarat!;
      }
      if (filter.toCarat != null) {
        matches = matches && (product.carat ?? 0) <= filter.toCarat!;
      }

      return matches;
    }).toList();

    emit(state.copyWith(
        getProductsStatus: FormzSubmissionStatus.success,
        products: filteredProducts));
  }

  void setSortCriteria(String? criteria) {
    emit(state.copyWith(sortCriteria: criteria));
  }

  void sortProducts({required bool ascending}) {
    List<ProductModel> sortedProducts = List.from(state.products);
    if (state.sortCriteria == 'price') {
      sortedProducts.sort((a, b) => ascending
          ? (a.finalAmount ?? 0).compareTo(b.finalAmount ?? 0)
          : (b.finalAmount ?? 0).compareTo(a.finalAmount ?? 0));
    } else if (state.sortCriteria == 'carat') {
      sortedProducts.sort((a, b) => ascending
          ? (a.carat ?? 0).compareTo(b.carat ?? 0)
          : (b.carat ?? 0).compareTo(a.carat ?? 0));
    }
    emit(state.copyWith(sortedProducts: sortedProducts));
  }

  void clearSorting() {
    emit(state.copyWith(clearSorting: true, sortedProducts: []));
  }
}
