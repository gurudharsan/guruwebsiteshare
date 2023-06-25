import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:cpcdiagnostics_ecommerce/src/models/all_shop_model.dart';
import 'package:cpcdiagnostics_ecommerce/src/utils/app_tags.dart';
import 'package:cpcdiagnostics_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../servers/repository.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/shimmer_shop.dart';
import '../../../widgets/loader/shimmer_shop_load.dart';
import '../../../widgets/shop_card.dart';

class AllShop extends StatefulWidget {
  const AllShop({Key? key}) : super(key: key);

  @override
  State<AllShop> createState() => _AllShopState();
}

class _AllShopState extends State<AllShop> {
  int page = 0;
  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  Future<List<Data>> getData(int offset) async {
    //page = (offset / 1).round();
    page++;
    return await Repository().getAllShop(page: page);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isMobile(context)? AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.allShop.tr,
            style: AppThemeData.headerTextStyle_16,
          ),
        ):AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60.h,
          leadingWidth: 40.w,
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25.r
            ),
            onPressed: () {
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.allShop.tr,
            style:  AppThemeData.headerTextStyleTab,
          ),
        ),
        body: PaginationView<Data>(
          key: key,
          paginationViewType: paginationViewType,
          pageFetch: getData,
          pullToRefresh: false,
          onError: (dynamic error) =>
              Center(child: Text(AppTags.someErrorOccurred.tr)),
          onEmpty: const Center(child: Text(AppTags.noProduct)),
          bottomLoader: const ShimmerShopLoad(),
          initialLoader: const ShimmerShop(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile(context)?3:4,
            childAspectRatio: 0.72,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (BuildContext context, Data shop, int index) {
            return ShopCard(shop: shop);
          },
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          shrinkWrap: true,
        ));
  }
}
