import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:cpcdiagnostics_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:cpcdiagnostics_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:cpcdiagnostics_ecommerce/src/utils/app_tags.dart';
import 'package:cpcdiagnostics_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:cpcdiagnostics_ecommerce/src/utils/responsive.dart';

import '../_route/routes.dart';

class ProductCardList extends StatelessWidget {
  ProductCardList({
    Key? key,
    required this.dataModel,
    required this.index,
  }) : super(key: key);
  final dynamic dataModel;
  final int index;
  final currencyConverterController = Get.find<CurrencyConverterController>();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeScreenController());
    return Ribbon(
      farLength: dataModel[index].isNew! ? isMobile(context)?20:30 : 1,
      nearLength: dataModel[index].isNew! ?  isMobile(context)?40:50 : 1,
      title: AppTags.neW.tr,
      titleStyle:  TextStyle(
        fontSize:  isMobile(context)?10.sp:7.sp,
        fontFamily: 'Poppins',
      ),
      color: AppThemeData.productBannerColor,
      location: RibbonLocation.topEnd,
      child: Container(
        height: 230.h,
        width:  isMobile(context)? 165.w:125.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
          boxShadow: [
            BoxShadow(
              color: AppThemeData.boxShadowColor.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20.r,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              Routes.detailsPage,
              parameters: {
                'productId': dataModel[index]
                    .id!
                    .toString(),
              },
            );
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        dataModel[index].specialDiscountType == 'flat'
                            ? double.parse(dataModel[index].specialDiscount) ==
                                    0.000
                                ? const SizedBox()
                                : Container(
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: AppThemeData.productBoxDecorationColor
                                          .withOpacity(0.06),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${currencyConverterController.convertCurrency(dataModel[index].specialDiscount)} OFF",
                                        style: isMobile(context)?AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                      ),
                                    ),
                                  )
                            : dataModel[index].specialDiscountType ==
                                    'percentage'
                                ? double.parse(
                                            dataModel[index].specialDiscount) ==
                                        0.000
                                    ? const SizedBox()
                                    : Container(
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: AppThemeData.productBoxDecorationColor
                                              .withOpacity(0.06),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${homeController.removeTrailingZeros(dataModel[index].specialDiscount)}% OFF",
                                            textAlign: TextAlign.center,
                                            style:
                                            isMobile(context)?AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                          ),
                                        ),
                                      )
                                : Container(),
                      ],
                    ),
                    double.parse(dataModel[index].specialDiscount) == 0.000
                        ? const SizedBox()
                        : SizedBox(width: 5.w),
                    dataModel[index].currentStock == 0
                        ? Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppThemeData.productBoxDecorationColor.withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                            ),
                            child: Center(
                              child: Text(
                                AppTags.stockOut.tr,
                                style: isMobile(context)?AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Image.network(
                    dataModel[index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  dataModel[index].title!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: isMobile(context)?AppThemeData.todayDealTitleStyle:AppThemeData.todayDealTitleStyleTab,
                ),
              ),
              SizedBox(height: 5.h),
/*              Padding(
                padding: EdgeInsets.symmetric(horizontal:isMobile(context)? 18.w:10.w),
                child: Center(
                  child: double.parse(dataModel[index].specialDiscount) == 0.000
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(dataModel[index].price!),
                              style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle: AppThemeData.todayDealDiscountPriceStyleTab,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(dataModel[index].price!),
                              style:isMobile(context)? AppThemeData.todayDealOriginalPriceStyle:AppThemeData.todayDealOriginalPriceStyleTab,
                            ),
                            Text(
                              currencyConverterController.convertCurrency(
                                  dataModel[index].discountPrice!),
                              style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle: AppThemeData.todayDealDiscountPriceStyleTab,
                            ),
                          ],
                        ),
                ),
              )*/
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
