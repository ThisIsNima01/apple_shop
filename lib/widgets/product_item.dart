import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/comment/bloc/comment_bloc.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<BasketBloc>.value(
                  value: locator.get<BasketBloc>(),
                ),
                BlocProvider(
                  create: (context) {
                    final commentBloc = CommentBloc(locator.get());
                    commentBloc.add(CommentInitialEvent(product.id));
                    return commentBloc;
                  },
                )
              ],
              child: ProductDetailScreen(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216.h,
        width: 160.w,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                SizedBox(
                  height: 98,
                  child: CachedImage(
                    imageUrl: product.thumbnail,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10.w,
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: SvgPicture.asset('assets/icons/like-filled.svg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        '${product.percent!.round().toString()} %',
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                  child: Text(
                    textAlign: TextAlign.right,
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.onSurface),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary,
                          blurRadius: 25,
                          spreadRadius: -12,
                          offset: const Offset(0, 16),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'تومان',
                            style: theme.textTheme.bodySmall!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontFamily: 'SM'),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.price.separateByComma(),
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontFamily: 'SM',
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.white,
                                ),
                              ),
                              Text(
                                (product.price + product.discountPrice)
                                    .separateByComma(),
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontFamily: 'SM'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 24.w,
                            child: SvgPicture.asset(
                                'assets/icons/arrow-right-filled.svg',
                                height: 20.h),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
