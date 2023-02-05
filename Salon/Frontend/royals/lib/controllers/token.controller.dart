// ignore_for_file: camel_case_types

import 'package:get/get.dart';

class tokenHolder extends GetxController {
  var usertoken = '';
  var userId = 0;
  var bookingID = 0;
  var bookUserID = 0;
  var historyID = 0;
  getToken(String token) {
    usertoken = token;
  }

  getUserId(int id) {
    userId = id;
  }

  getBookingID(int id, int bID, int hID) {
    bookingID = id;
    bookUserID = bID;
    historyID = hID;
  }
}
