import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/base/custom_loader.dart';
import 'package:pet_care_app/base/show_custom_snackbar.dart';
import 'package:pet_care_app/controllers/auth_controller.dart';
import 'package:pet_care_app/models/signup_body_model.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/colors.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:pet_care_app/widgets/app_text_field.dart';
import 'package:pet_care_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImges = ["f.png", "g.png", "t.jpg"];

    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Vui lòng nhập họ tên", title: "Họ Tên");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Vui lòng nhập số điện thoại",
            title: "Số điện thoại");
      } else if (email.isEmpty) {
        showCustomSnackBar("Vui lòng nhập địa chỉ email",
            title: "Địa chỉ email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Vui lòng nhập đúng định dạng địa chỉ email",
            title: "Địa chỉ email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Vui lòng nhập mật khẩu", title: "Mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackBar("Mật khẩu không được ít hơn 6 kí tự",
            title: "Mật khẩu");
      } else {
        acceptSnackBar("Tạo thành công", title: "Hoàn thành");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //app logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/image/logo.jpg"),
                          ),
                        ),
                      ),
                      //email
                      AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //name
                      AppTextField(
                          textController: nameController,
                          hintText: "Họ tên",
                          icon: Icons.person),
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
                      //phone
                      AppTextField(
                          textController: phoneController,
                          hintText: "Số điện thoại",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //sign up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Đăng kí",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      //sign up
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Đã có tài khoản",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20))),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //sign up options
                      RichText(
                          text: TextSpan(
                              text:
                                  "Đăng ký bằng một trong các phương pháp sau",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImges[index]),
                                  ),
                                )),
                      )
                    ]),
                  )
                : const CustomLoader();
          },
        ));
  }
}
