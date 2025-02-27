part of 'cart_cubit.dart';

class CartState extends Equatable {
  final FormzSubmissionStatus addCartStatus;
  final FormzSubmissionStatus removeCartStatus;
  final List<ProductModel> cartProducts;
  const CartState({
    this.addCartStatus = FormzSubmissionStatus.initial,
    this.removeCartStatus = FormzSubmissionStatus.initial,
    this.cartProducts = const [],
  });

  CartState copyWith({
    FormzSubmissionStatus? addCartStatus,
    FormzSubmissionStatus? removeCartStatus,
    List<ProductModel>? cartProducts,
  }) =>
      CartState(
        addCartStatus: addCartStatus ?? this.addCartStatus,
        removeCartStatus: removeCartStatus ?? this.removeCartStatus,
        cartProducts: cartProducts ?? this.cartProducts,
      );

  @override
  List<Object?> get props => [
        addCartStatus,
        removeCartStatus,
        cartProducts,
      ];
}
