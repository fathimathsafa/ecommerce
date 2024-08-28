import 'dart:developer';

import 'package:demo/fake_store/core/app_utils.dart';
import 'package:demo/fake_store/repository/api/cart_model.dart';
import 'package:demo/fake_store/repository/api/cart_service.dart';
import 'package:flutter/material.dart';


class CartController with ChangeNotifier {
  bool isLoading = false;
  CartModel cartModel = CartModel();

  fetchData(context) {
    isLoading = true;
    notifyListeners();
    log("CartController -> fetchData");
    CartService.fetchData().then((value) {
      log("CartService.fetchData() started");
      if (value["status"] == 1) {
        log("data==== ->${value["data"]}");
        cartModel = CartModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("error", context: context);
      }
      notifyListeners();
    });
  }
}
