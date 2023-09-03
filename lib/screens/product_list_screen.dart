import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/loading.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/categoryProduct/category_product_bloc.dart';
import '../constants/colors.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;

  const ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    context
        .read<CategoryProductBloc>()
        .add(CategoryProductInitialized(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is CategoryProductLoading) ...{
                  // const SliverFillRemaining(
                  //   child: LoadingItems(title: 'درحال دریافت محصولات'),
                  // ),
                },
                if (state is CategoryProductSuccess) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 32.w,
                        right: 32.w,
                        bottom: 32.h,
                        top: 16.h,
                      ),
                      child: Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16.w,
                            ),
                            SvgPicture.asset('assets/icons/apple.svg',
                                color: CustomColors.blue, width: 24.w),
                            Expanded(
                              child: Text(
                                widget.category.title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16.sp,
                                  color: CustomColors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.productListByCategory.fold(
                    (l) => const SliverToBoxAdapter(
                      child: Text('خطا'),
                    ),
                    (productList) => SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: productList.length,
                          (context, index) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ProductItem(productList[index]),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.9 / 2.6,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: 16.h)),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}
