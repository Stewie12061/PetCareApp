import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; //screen height = 884px
  static double screenWidth = Get.context!.width; //screen width = 390px

  static double pageView = screenHeight / 2.64; //320px
  static double pageViewContainer = screenHeight / 3.84; //230px
  static double pageViewTextContainer = screenHeight / 7.03; //12px
  //dynamic height padding and margin
  static double height10 = screenHeight / 84.4; //10px
  static double height15 = screenHeight / 56.27; //15px
  static double height20 = screenHeight / 42.2; //20px
  static double height30 = screenHeight / 28.13; //30px
  static double height45 = screenHeight / 18.76; //45px
  static double height55 = screenHeight / 16.07; //55px
  //dynamic width padding and margin
  static double width10 = screenHeight / 84.4; //10px
  static double width15 = screenHeight / 56.27; //15px
  static double width20 = screenHeight / 42.2; //20px
  static double width30 = screenHeight / 28.13; //30px
  static double width45 = screenHeight / 18.7; //45px
  //dynamic font
  static double font16 = screenHeight / 52.75; //16px
  static double font20 = screenHeight / 42.2; //20px
  static double font26 = screenHeight / 32.46; //26px
  //dynamic radius
  static double radius15 = screenHeight / 56.27; //15px
  static double radius20 = screenHeight / 42.2; //20px
  static double radius30 = screenHeight / 28.13; //30px
  //dynamic icon size
  static double iconSize16 = screenHeight / 52.75; //16px
  static double iconSize24 = screenHeight / 35.17; //24px
  //dynamic list view size
  static double listViewImgSize = screenWidth / 3.25; // 120px
  static double listViewTextContainerSize = screenWidth / 3.9; // 100px
  //popular food
  static double popularFoodImgSize = screenHeight / 2.41; //360px
  //bottom height
  static double bottomHeightBar = screenHeight / 7.03; //120px

  //splash sreeen dimensions
  static double splashImg = screenHeight / 3.38;
}
