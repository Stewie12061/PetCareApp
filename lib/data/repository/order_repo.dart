import 'package:pet_care_app/models/place_order_model.dart';
import 'package:pet_care_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response>  placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI,placeOrder.toJson());
  }
}