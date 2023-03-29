import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/base/custom_loader.dart';
import 'package:pet_care_app/controllers/auth_controller.dart';
import 'package:pet_care_app/controllers/cart_controller.dart';
import 'package:pet_care_app/controllers/location_controller.dart';
import 'package:pet_care_app/controllers/user_controller.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/colors.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:pet_care_app/widgets/account_widget.dart';
import 'package:pet_care_app/widgets/app_icon.dart';
import 'package:pet_care_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Thông tin",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height45 + Dimensions.height30,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(children: [
                              //name
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 + 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.name,
                                  )),
                              //phone
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 + 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.phone,
                                  )),
                              //email
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 + 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.email,
                                  )),
                              //address
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              GetBuilder<LocationController>(builder: (locationController){
                                if(_userLoggedIn&& locationController.addressList.isEmpty){
                                  return GestureDetector(
                                    onTap: (){
                                      Get.offNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize: Dimensions.height10 + 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              // text: userController.userModel.name,
                                              text: "Điền địa chỉ của bạn")),
                                  );
                                }else{
                                  return GestureDetector(
                                    onTap: (){
                                      Get.offNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize: Dimensions.height10 + 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              // text: userController.userModel.name,
                                              text: "Địa chỉ của bạn")),
                                  );
                                }
                              }),
                              //message
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message_outlined,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 + 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.name,
                                  )),
                              //message
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.find<LocationController>().clearAddressList();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 + 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "Đăng xuất",
                                    )),
                              )
                            ]),
                          ))
                        ],
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*8,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/image/signintocontinue.png"))),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Đăng nhập",
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                            )),
                      )
                    ],
                  )),
                );
        }));
  }
}
