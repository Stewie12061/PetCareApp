import 'package:flutter/material.dart';
import 'package:pet_care_app/base/no_data_page.dart';
import 'package:pet_care_app/base/show_custom_snackbar.dart';
import 'package:pet_care_app/controllers/auth_controller.dart';
import 'package:pet_care_app/controllers/cart_controller.dart';
import 'package:pet_care_app/controllers/location_controller.dart';
import 'package:pet_care_app/controllers/order_controller.dart';
import 'package:pet_care_app/controllers/popular_product_controller.dart';
import 'package:pet_care_app/controllers/recommended_product_controller.dart';
import 'package:pet_care_app/controllers/user_controller.dart';
import 'package:pet_care_app/models/place_order_model.dart';
import 'package:pet_care_app/pages/home/main_food_page.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/app_constants.dart';
import 'package:pet_care_app/utils/colors.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:pet_care_app/widgets/app_icon.dart';
import 'package:pet_care_app/widgets/big_text.dart';
import 'package:pet_care_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    // size: Dimensions.iconSize24,
                    size: 30,
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child:                    
                     AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      size: 30,
                      
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_bag_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    // size: Dimensions.iconSize24,
                    size: 30,
                  )
                ],
              ),
            ),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        // color: Colors.white,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  (RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage")));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar(
                                                  "Sản phẩm",
                                                  "Sản phẩm không tồn tại trong lịch sử sản phẩm",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed((RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage")));
                                              }
                                            }
                                          },
                                          child: Container(),
                                        ),
                                        Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                            bottom: Dimensions.height10,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: NumberFormat
                                                              .currency(
                                                                  locale: 'vi')
                                                          .format(cartController
                                                              .getItems[index]
                                                              .price),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .iconColor1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radius20,
                                                        ),
                                                      ),
                                                      child: cartController
                                                                  .getItems
                                                                  .length >
                                                              0
                                                          ? Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cartController.addItem(
                                                                        _cartList[index]
                                                                            .product!,
                                                                        -1);
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: AppColors
                                                                        .signColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .width10 /
                                                                      2,
                                                                ),
                                                                BigText(
                                                                    text: _cartList[
                                                                            index]
                                                                        .quantity
                                                                        .toString()), //popularProduct.inCartItems.toString()),
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .width10 /
                                                                      2,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cartController.addItem(
                                                                        _cartList[index]
                                                                            .product!,
                                                                        1);
                                                                  },
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: AppColors
                                                                        .signColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    )
                  : NoDataPage(text: "Giỏ hàng của bạn đang trống");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.width10 / 2),
                        BigText(
                            text: NumberFormat.currency(locale: 'vi')
                                .format(cartController.totalAmount)),
                        SizedBox(width: Dimensions.width10 / 2),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // popularProduct.addItem(product);
                      if (Get.find<AuthController>().userLoggedIn()) {
                        if (Get.find<LocationController>()
                            .addressList
                            .isEmpty) {
                          Get.toNamed(RouteHelper.getAddressPage());
                        } else {
                          // Get.offNamed(RouteHelper.getInitial());
                          // Get.offNamed(RouteHelper.getPaymentPage("100127", Get.find<UserController>().userModel!.id));
                          var location = Get.find<LocationController>().getUserAddress();
                          var cart = Get.find<CartController>().getItems;
                          var user = Get.find<UserController>().userModel;
                          PlaceOrderBody placeOrder =  PlaceOrderBody(
                            cart: cart,
                            orderAmount: 100.0,
                            orderNote: "Không phải bánh",
                            address: location.address,
                            latitude: location.latitude,
                            longitude: location.longitude,
                            contactPersonNumber:  user!.phone,
                            contactPersonName: user.name,
                            scheduleAt: '', distance: 10.0
                          );
                          Get.find<OrderController>().placeOrder(
                            placeOrder,
                            _callback
                            );
                        }
                      } else {
                        Get.toNamed(RouteHelper.getSignInPage());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          //popularProduct.addItem(product);
                        },
                        child: BigText(
                          text: "Mua",
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
  void _callback(bool isSuccess, String message, String orderID){
    if(isSuccess){
 Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
    }else{
      showCustomSnackBar(message);
    }
  }
}
