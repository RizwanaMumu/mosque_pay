import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pay/core/model/mosque_model.dart';
import 'package:pay/core/model/town_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as logDev;

import '../../common & constant classes/common_functions.dart';
import '../../common & constant classes/constants.dart';

bool checkSessionExpiry = false;

class Api {
  var client = http.Client();
  Map<String, String> headers = {"content-type": "application/json"};
  Map<String, String> messageheaders = {"content-type": "application/json"};
  //Map<String, String> cookies = {};


  _checkSessionExpiry(String string) {
    if (string.contains("Invaild access")) {
      if (kDebugMode) {
        print("token expired.");
      }
      checkSessionExpiry = true;
    } else {
      checkSessionExpiry = false;
    }
  }

  Future<List<MosqueModel>> getMosqueList(BuildContext context, String searchedTxt) async {
    //https://www.mosquepay.co.uk/api/mosque_list.php

    final Map<String, dynamic> params = {
      "search" : searchedTxt
    };
    print(params);
    final String endpoint = '/api/mosque_list.php';//'/api/account.invoice/search';

    var url = URLConstants.baseUrl +
        endpoint +
        ((params != null) ? this.queryParameters(params) : "");

    //var client = http.Client();
    List<MosqueModel> responseList = [];

    print(url);

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        _checkSessionExpiry(jsonString.toString());
        responseList = mosqueModelFromJson(jsonString);
        return responseList;
      } else {
        return responseList;
      }
    } catch (Exception) {

      print(Exception);
      CommonFunctions().showErrorToast(context, "Server Error. Logging Out!\n Please Try Again Later");

      return [];

    }
  }

  Future<List<TownModel>> getTownList(BuildContext context, String searchedText) async {
    //https://www.mosquepay.co.uk/api/town_list.php

    final Map<String, dynamic> params = {
      'search': searchedText
    };
    print(params);
    final String endpoint = '/api/town_list.php';//'/api/account.invoice/search';

    var url = URLConstants.baseUrl +
        endpoint +
        ((params != null) ? this.queryParameters(params) : "");

    //var client = http.Client();
    List<TownModel> responseList = [];

    print(url);

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        _checkSessionExpiry(jsonString.toString());
      responseList = townModelFromJson(jsonString);
        return responseList;
      } else {
        return responseList;
      }
    } catch (Exception) {

      print(Exception);
      CommonFunctions().showErrorToast(context, "Server Error. Logging Out!\n Please Try Again Later");

      return [];

    }
  }


  /////////-------------------Common------------------/////////
  String queryParameters(Map<String, dynamic> params) {
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }
}
