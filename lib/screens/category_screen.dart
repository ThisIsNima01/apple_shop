import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/project_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryRequest());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is CategoryLoadingState) ...[
                  _loadingWidget(),
                ],
                if (state is CategoryResponseState) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 44.w,
                        right: 44.w,
                        bottom: 32.h,
                        top: 20.h,
                      ),
                      child: const ProjectAppBar(appbarTitle: 'جستجوی محصولات'),
                    ),
                  ),
                  state.response.fold(
                      (l) => SliverToBoxAdapter(
                            child: Text(l),
                          ),
                      (r) => CategoryList(categoryList: r))
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  SliverFillRemaining _loadingWidget() {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          LoadingAnimationWidget.beat(color: CustomColors.blue, size: 32),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'درحال دریافت لیست دسته بندی',
            style: TextStyle(
                fontSize: 14, fontFamily: 'SB', color: CustomColors.grey),
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category>? categoryList;

  const CategoryList({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CategoryProductBloc(),
                    child: ProductListScreen(categoryList![index]),
                  ),
                ));
              },
              child: CachedImage(
                imageUrl: categoryList?[index].thumbnail!,
                radius: 16.r,
              )),
          childCount: categoryList?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
