import 'dart:developer';

import 'package:demo/fake_store/repository/helper/api_helper.dart';
class HomeScreenService{
  static Future <dynamic> fetchData() async{
    log("HomeScreenService -> started");
    try{
      var decodedData = await ApiHelper.getData(endPoint: "/products");
      return decodedData;
    }catch(e){
      log("$e");
    }
  }
}