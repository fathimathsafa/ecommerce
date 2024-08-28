// import 'dart:developer';

// import 'package:demo/fake_store/core/app_utils.dart';
// import 'package:demo/fake_store/presentation/home_screen/model/home_screen_model.dart';
// import 'package:demo/fake_store/repository/api/home_screen/serivce/home_screen_service.dart';
// import 'package:flutter/cupertino.dart';


// class HomeScreenController extends ChangeNotifier {
//   List <HomeScreenModel> datas=[];
//   HomeScreenModel homeScreenModel = HomeScreenModel();
//   bool isLoading = false;
//   int cartItemCount = 0;
//   List<HomeScreenModel> cartItems = [];
//   fetchData(BuildContext context) async {
//     isLoading = true;
//     notifyListeners();
//     log("HomeScreenController -> fetchData");

//     try {
//       final value = await HomeScreenService.fetchData();
//       log("HomeScreenService.fetchData() started");

//       if (value != null) {
//         if (value["status"] == 1) {
//           homeScreenModel = HomeScreenModel.fromJson(value);
//           isLoading = false;
//         } else {
//           AppUtils.oneTimeSnackBar("error", context: context);
//         }
//       } else {
//         AppUtils.oneTimeSnackBar("error", context: context);
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       isLoading = false;
//     }

//     notifyListeners();
//   }
//   void addToCart(HomeScreenModel item) {
//     cartItems.add(item); // Add item to cart
//     cartItemCount++; // Increment cart item count
//     notifyListeners(); // Notify listeners to update UI
//   }
//   void incrementCartItemCount() {
//     cartItemCount++;
//     notifyListeners();
//   }

//   // fetchData(context) async {
//   //   isLoading = true;
//   //   notifyListeners();
//   //   log("HomeScreenController -> fetchData");
//   //   HomeScreenService.fetchData().then((value) {
//   //     log("HomeScreenService.fetchData() started");
//   //     if (value["status"] == 1) {
//   //       log("data==== ->${value["data"]}");
//   //       homeScreenModel = HomeScreenModel.fromJson(value);
//   //       isLoading = false;
//   //     } else {
//   //       AppUtils.oneTimeSnackBar("error", context: context);
//   //     }
//   //     notifyListeners();
//   //   });
//   // }
// }
import 'dart:developer';

import 'package:demo/fake_store/presentation/home_screen/model/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends ChangeNotifier {
  List<ProductModel> productList = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      Uri uri = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(uri);

      if (response.statusCode >= 200 || response.statusCode < 300) {
        productList = productModelListFromJson(response.body);
      } else {
        log('failed to fetch data');
      }
    } on Exception catch (e) {
      log('failed with exception : $e');
    }
    isLoading = false;
    notifyListeners();
  }
}