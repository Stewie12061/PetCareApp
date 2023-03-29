import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    /**
     * Any class(){
     *  newObject(){
     *    return ..
     *  }
     * }
     * var x = AnyClass()..newObject()
     *  x = x.bewObject()
     * 
     */

    super.initState();
    _loadResource();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
                scale: animation,
                child: Center(
                  child: Image.asset(
                    "assets/image/logo.jpg",
                    width: Dimensions.splashImg,
                  ),
                ))
          ],
        ));
  }
}
