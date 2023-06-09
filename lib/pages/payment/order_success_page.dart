import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/base/custom_button.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({ required this.orderID, required this.status}) ;

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(Duration(seconds: 1),(){

      });
    }
    return Scaffold(
      body: Center(child: SizedBox(width: Dimensions.screenWidth, child: 
      Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        Image.asset(status==1?"assets/image/checked.png":
        "assets/image/warning.png", width: 100, height: 100),
        SizedBox(height: Dimensions.height45,),
        Text(
          status == 1?'Bạn đặt hàng thành công': 'Bạn đặt hàng thất bại',
          style: TextStyle(fontSize: Dimensions.font26),
        ),
        SizedBox(height: Dimensions.height20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
            vertical: Dimensions.height20),
            child: Text(
              status == 1?"Đặt hàng thành công": "Đặt hàng thất bại",
              style: TextStyle(fontSize: Dimensions.font20,
                color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(Dimensions.height20),
              child: CustomButton(buttonText: "Về trang chủ",onPressed: 
              ()=> Get.offAllNamed(RouteHelper.getInitial())),
            ),
          
      ]))),
    );
  }
}