part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final FormzSubmissionStatus getProductsStatus;
  final List<ProductModel> products;
  final FilterModel filter;
  final List<ProductModel> sortedProducts;
  final String? sortCriteria;
  const ProductsState({
    this.getProductsStatus = FormzSubmissionStatus.initial,
    this.products = const [],
    this.filter = const FilterModel(),
    this.sortedProducts = const [],
    this.sortCriteria,
  });

  ProductsState copyWith({
    FormzSubmissionStatus? getProductsStatus,
    List<ProductModel>? products,
    FilterModel? filter,
    List<ProductModel>? sortedProducts,
    String? sortCriteria,
    bool? clearSorting,
  }) =>
      ProductsState(
        getProductsStatus: getProductsStatus ?? this.getProductsStatus,
        products: products ?? this.products,
        filter: filter ?? this.filter,
        sortedProducts: sortedProducts ?? this.sortedProducts,
        sortCriteria:
            clearSorting == true ? null : sortCriteria ?? this.sortCriteria,
      );

  @override
  List<Object?> get props => [
        getProductsStatus,
        products,
        filter,
        sortedProducts,
        sortCriteria,
      ];
}
