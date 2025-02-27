import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kgk/core/db/hive_helper.dart';
import 'package:kgk/features/products/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());
  final HiveDBHelper _hiveDBHelper = HiveDBHelper();

  void addToCart(ProductModel product) async {
    emit(state.copyWith(addCartStatus: FormzSubmissionStatus.inProgress));
    _hiveDBHelper.addToCart(product.toJson());
    final List<ProductModel> cartProducts = List.from(state.cartProducts);
    cartProducts.add(product);
    emit(state.copyWith(
        addCartStatus: FormzSubmissionStatus.success,
        cartProducts: cartProducts));
  }

  void removeFromCart(ProductModel product) async {
    emit(state.copyWith(removeCartStatus: FormzSubmissionStatus.inProgress));
    _hiveDBHelper.removeFromCart(product.id ?? '');
    final List<ProductModel> cartProducts = List.from(state.cartProducts);
    cartProducts.removeWhere((element) => element.id == product.id);
    emit(state.copyWith(
        removeCartStatus: FormzSubmissionStatus.success,
        cartProducts: cartProducts));
  }

  void getCartItems() {
    final items = _hiveDBHelper.getCartItems();
    final List<Map<String, dynamic>> cartItems =
        items.map((item) => Map<String, dynamic>.from(item)).toList();
    final List<ProductModel> cartProducts =
        cartItems.map((product) => ProductModel.fromJson(product)).toList();
    emit(state.copyWith(cartProducts: cartProducts));
  }

  void clearCart() {
    _hiveDBHelper.clearCart();
    emit(state.copyWith(cartProducts: []));
  }

  bool isProductInCart(ProductModel product) {
    return state.cartProducts.any((element) => element.id == product.id);
  }

  int getCartCount() {
    return state.cartProducts.length;
  }

  double getTotalCarat() {
    return state.cartProducts
        .fold(0.0, (sum, product) => sum + (product.carat ?? 0));
  }

  double getTotalPrice() {
    return state.cartProducts
        .fold(0.0, (sum, product) => sum + (product.finalAmount ?? 0));
  }

  double getAveragePrice() {
    if (state.cartProducts.isEmpty) return 0.0;
    return getTotalPrice() / state.cartProducts.length;
  }

  double getAverageDiscount() {
    if (state.cartProducts.isEmpty) return 0.0;
    return state.cartProducts
            .fold(0.0, (sum, product) => sum + (product.discount ?? 0)) /
        state.cartProducts.length;
  }
}
