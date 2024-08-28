import 'dart:developer';

import 'package:demo/fake_store/repository/helper/api_helper.dart';

class CartService{
  static Future <dynamic> fetchData() async {
    log("CartService  -> started");
    try{
      var decodedData = await ApiHelper.getData(endPoint: "/carts?userId=1");
      return decodedData;
    }catch(e){
      log("$e");
    }
  }
}