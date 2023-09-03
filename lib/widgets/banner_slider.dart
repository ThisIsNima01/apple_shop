import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerCampain> bannerList;
  final List<Product> productList;

  const BannerSlider(this.bannerList, this.productList, {super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          child: CarouselSlider.builder(
            itemCount: widget.bannerList.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  child: CachedImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.bannerList[index].thumbnail,
                    radius: 16.r,
                  ),
                ),
                onTap: () {
                  for (var product in widget.productList) {
                    if (product.id == widget.bannerList[index].productId) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<BasketBloc>.value(
                            value: locator.get<BasketBloc>(),
                            child: ProductDetailScreen(product),
                          ),
                        ),
                      );
                    }
                  }
                },
              );
            },
            options: CarouselOptions(
              height: deviceSize.height * 0.24.h,
              viewportFraction: .9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _activeIndex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          child: AnimatedSmoothIndicator(
            activeIndex: _activeIndex,
            count: widget.bannerList.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}
