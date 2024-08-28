import 'package:demo/fake_store/presentation/home_screen/model/home_screen_model.dart';

class CartItemModel {
  int quantity;
  ProductModel product;
  CartItemModel({
    this.quantity = 1,
    required this.product,
  });
}