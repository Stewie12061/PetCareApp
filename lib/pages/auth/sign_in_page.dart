import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/base/custom_loader.dart';
import 'package:pet_care_app/pages/auth/sign_up_page.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/colors.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:pet_care_app/widgets/app_text_field.dart';
import 'package:pet_care_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      if (phone.isEmpty) {
        showCustomSnackBar("Vui lòng nhập số điện thoại",
            title: "Số điện thoại");
      } else if (password.isEmpty) {
        showCustomSnackBar("Vui lòng nhập mật khẩu", title: "Mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackBar("Mật khẩu không được ít hơn 6 kí tự",
            title: "Mật khẩu");
      } else {
        acceptSnackBar("Tạo thành công", title: "Hoàn thành");
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //app logo
                    Container(
                      height: Dimensions.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: AssetImage("assets/image/logo.png"),
                        ),
                      ),
                    ),
                    //wellcome
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Xin chào",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font20 * 3 + Dimensions.font20 / 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Đăng nhập vào tài khoản của bạn",
                            style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    //phone
                    AppTextField(
                        textController: phoneController,
                        hintText: "Số điện thoại",
                        icon: Icons.phone),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //password
                    AppTextField(
                      textController: passwordController,
                      hintText: "Mật khẩu",
                      icon: Icons.password,
                      isObscure: true,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //tap line
                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                text: "Đăng nhập vào tài khoản của bạn",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20))),
                        SizedBox(width: Dimensions.width20)
                      ],
                    ),

                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //sign in
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: "Đăng nhập",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //sign up options
                    RichText(
                        text: TextSpan(
                            text: "Không có tài khoản",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => SignUpPage(),
                                    transition: Transition.fade),
                              text: "Tạo tài khoản",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.font20))
                        ])),
                  ]),
                )
              : CustomLoader();
        }));
  }
}
