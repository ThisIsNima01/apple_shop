import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/categoryProduct/category_product_bloc.dart';
import '../screens/product_list_screen.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;
  const CategoryItemChip(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: ()=> Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category),
            ),
          )),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                // constraints: BoxConstraints(maxHeight: 56.h, maxWidth: 56.w),
                height: 56.h,
                width: 56.w,
                decoration: ShapeDecoration(
                  // color: Color(int.parse('0xff${category.color}')),
                  color: Color(hexColor),
                  shadows: const [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: -12,
                      offset: Offset(0, 16),
                      color: Colors.red,
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
              ),
              SizedBox(
                height: 26.h,
                width: 26.w,
                child: Center(child: CachedImage(imageUrl: category.icon)),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            category.title ?? 'محصول',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
