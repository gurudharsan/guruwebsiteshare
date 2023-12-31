import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cpcdiagnostics_ecommerce/src/controllers/splash_controller.dart';
import '../../utils/app_theme_data.dart';
import '../../utils/dynamic_links_service.dart';

class SplashScreen extends GetView<SplashController> {
   const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemeData.splashScreenColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 130.w,
                height: 70.h,
                child: Center(
                  child: Image.asset("assets/logos/logo.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
