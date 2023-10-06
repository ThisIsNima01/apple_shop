import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/comment/bloc/comment_bloc.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:apple_shop/data/model/property.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../data/model/product.dart';
import '../data/model/product_image.dart';
import '../data/model/product_variant.dart';
import '../data/model/variant.dart';
import '../data/model/variant_type.dart';
import '../data/model/variant_type_enum.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final List<BasketItemVariant> basketItemVariantList = [];

  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          var bloc = ProductBloc();
          bloc.add(ProductInitializeEvent(
              widget.product.id, widget.product.categoryId));
          return bloc;
        },
        child: DetailScreenContent(parentWidget: widget));
  }
}

class DetailScreenContent extends StatelessWidget {
  const DetailScreenContent({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductDetailLoadingState) {
            return const Center(
              child: LoadingItems(),
            );
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 44.w,
                        right: 44.w,
                        bottom: 32.h,
                        top: 12.h,
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
                                child: state.productCategory.fold(
                              (exceptionMessage) => Text(
                                'اطلاعات محصول',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: theme.colorScheme.primary),
                              ),
                              (productCategory) => Text(
                                productCategory.title!,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: theme.colorScheme.primary),
                              ),
                            )),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/arrow-right.svg',
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                  state.productImages.fold((l) {
                    return const SliverToBoxAdapter(
                      child: Text('خطا'),
                    );
                  }, (productImageList) {
                    return GalleryWidget(
                        productImageList, parentWidget.product.thumbnail);
                  }),
                  state.productVariants.fold((l) {
                    return const SliverToBoxAdapter(
                      child: Text('خطا'),
                    );
                  }, (productVariantList) {
                    return VariantContainerGenerator(
                        productVariantList, parentWidget.basketItemVariantList);
                  }),
                  state.productProperties.fold((l) {
                    return const ProductProperties([]);
                  },
                      (productPropertyList) =>
                          ProductProperties(productPropertyList)),
                  ProductDescription(parentWidget.product.description),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
                    sliver: SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            useSafeArea: true,
                            showDragHandle: true,
                            builder: (context) => BlocProvider(
                              lazy: false,
                              create: (context) {
                                final commentBloc = CommentBloc(locator.get());
                                commentBloc.add(CommentInitialEvent(
                                    parentWidget.product.id));
                                return commentBloc;
                              },
                              child: CommentBottomSheet(
                                productId: parentWidget.product.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 44.w),
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: CustomColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/arrow-left.svg'),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'مشاهده',
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: theme.colorScheme.primary),
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          height: 26.h,
                                          width: 26.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Image.asset(
                                              'assets/images/comments/0.png'),
                                        ),
                                      ),
                                      Positioned(
                                        right: 15.w,
                                        child: Container(
                                          height: 26.h,
                                          width: 26.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Image.asset(
                                              'assets/images/comments/1.png'),
                                        ),
                                      ),
                                      Positioned(
                                        right: 30.w,
                                        child: Container(
                                          height: 26.h,
                                          width: 26.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Image.asset(
                                              'assets/images/comments/2.png'),
                                        ),
                                      ),
                                      Positioned(
                                        right: 45.w,
                                        child: Container(
                                          height: 26.h,
                                          width: 26.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Image.asset(
                                              'assets/images/comments/3.png'),
                                        ),
                                      ),
                                      Positioned(
                                        right: 60.w,
                                        child: Container(
                                          height: 26.h,
                                          width: 26.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: Colors.grey,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '+10',
                                              style: theme.textTheme.labelSmall,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  ':نظرات کاربران',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontFamily: 'SM'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 44.w),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceTagButton(parentWidget.product),
                          AddToBasketButton(parentWidget.product,
                              parentWidget.basketItemVariantList),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  final String productId;
  final TextEditingController controller = TextEditingController();
  CommentBottomSheet({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return const Center(
            child: LoadingItems(),
          );
        }
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    if (state is CommentResponseState) ...{
                      state.comments.fold(
                          (l) => SliverToBoxAdapter(
                                child: Text(l),
                              ), (commentList) {
                        if (commentList.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: Text('نظری برای این محصول ثبت نشده است'),
                            ),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: commentList.length,
                            (context, index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.lightContainerColor,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          commentList[index].username.isNotEmpty
                                              ? commentList[index].username
                                              : 'کاربر',
                                          textAlign: TextAlign.end,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                          commentList[index].text.isNotEmpty
                                              ? commentList[index].text
                                              : 'نظر بدون متن',
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  SizedBox(
                                    width: 40.w,
                                    height: 40.h,
                                    child: commentList[index].avatar.isNotEmpty
                                        ? CachedImage(
                                            imageUrl: commentList[index]
                                                .userAvatarUrl,
                                          )
                                        : Image.asset(
                                            'assets/images/avatar.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    }
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'نظر من...',
                        labelStyle: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(
                              color: CustomColors.blue, width: 3),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 62.h,
                            decoration: BoxDecoration(
                              color: CustomColors.blue,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          Positioned(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller.text.isEmpty) {
                                      return;
                                    }
                                    context.read<CommentBloc>().add(
                                        CommentPostEvent(
                                            productId, controller.text));

                                    controller.text = '';
                                  },
                                  child: Container(
                                    height: 54.h,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'ثبت نظر',
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: theme
                                                    .colorScheme.onPrimary),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Property> propertyList;

  const ProductProperties(
    this.propertyList, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 44.w),
                height: 46.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/arrow-left.svg'),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        _isVisible ? 'بستن' : 'مشاهده',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: theme.colorScheme.primary),
                      ),
                      const Spacer(),
                      Text(
                        ':مشخصات فنی',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontFamily: 'SM'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                margin: EdgeInsets.only(left: 44.w, right: 44.w, top: 24.h),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: widget.propertyList.isEmpty
                    ? Text(
                        '! مشخصاتی برای این محصول یافت نشد',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontFamily: 'SM'),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.propertyList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                '${widget.propertyList[index].value} : ${widget.propertyList[index].title}',
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.colorScheme.onSurface,
                                    fontFamily: 'SM',
                                    height: 2),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String productDescription;

  const ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 44.w),
              height: 46.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.grey, width: 1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/arrow-left.svg'),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      _isVisible ? 'بستن' : 'مشاهده',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.colorScheme.primary),
                    ),
                    const Spacer(),
                    Text(
                      ':توضیحات محصول',
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurface, fontFamily: 'SM'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: EdgeInsets.only(left: 44.w, right: 44.w, top: 24.h),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.grey, width: 1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                widget.productDescription.isNotEmpty
                    ? widget.productDescription
                    : '! توضیحاتی برای این محصول یافت نشد',
                textAlign: TextAlign.right,
                style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontFamily: 'SM',
                    height: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;
  final List<BasketItemVariant> basketItemVariantList;

  const VariantContainerGenerator(
    this.productVariantList,
    this.basketItemVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantChildGenerator(productVariant, basketItemVariantList)
            }
          }
        ],
      ),
    );
  }
}

class VariantChildGenerator extends StatelessWidget {
  final ProductVariant productVariant;
  final List<BasketItemVariant> basketItemVariantList;

  const VariantChildGenerator(
    this.productVariant,
    this.basketItemVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        right: 44.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onSurface, fontFamily: 'SM'),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGTE) ...{
            StorageVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.VOLTAGE) ...{
            StorageVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          }
        ],
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  final Product product;
  final List<BasketItemVariant> basketItemVariantList;

  const AddToBasketButton(
    this.product,
    this.basketItemVariantList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  var item = BasketItem(
                      product.id,
                      product.collectionId,
                      product.thumbnail,
                      product.categoryId,
                      product.name,
                      product.price,
                      (product.price + product.discountPrice),
                      basketItemVariantList:
                          _getBasketItemVariants(basketItemVariantList));

                  BlocProvider.of<BasketBloc>(context)
                      .add(BasketItemAdded(cartItem: item));

                  AnimatedSnackBar(
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    duration: const Duration(seconds: 4),
                    builder: ((context) {
                      return Container(
                        decoration: BoxDecoration(
                            color: CustomColors.green,
                            borderRadius: BorderRadius.circular(20.r)),
                        height: 50.h,
                        child: Center(
                          child: Text(
                            'محصول به سبد خرید افزوده شد.',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.onSecondary,
                              fontFamily: 'SM',
                              height: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                  ).show(context);
                },
                child: Container(
                  width: 160.w,
                  height: 58.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Text(
                      'افزودن به سبد خرید',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  final Product product;

  const PriceTagButton(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 160.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Text(
                        'تومان',
                        style: theme.textTheme.bodySmall!.copyWith(
                            fontFamily: 'SM',
                            color: theme.colorScheme.onSecondary),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.price.separateByComma(),
                            style: theme.textTheme.bodySmall!.copyWith(
                                fontFamily: 'SM',
                                color: theme.colorScheme.onSecondary,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white),
                          ),
                          Text(
                            (product.price + product.discountPrice)
                                .separateByComma(),
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: theme.colorScheme.onSecondary),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColors.red,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          child: Text(
                            '%${product.percent!.round()}',
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final List<ProductImage> productImageList;
  final String? defaultProductThumbnail;
  int selectedItem = 0;

  GalleryWidget(this.productImageList, this.defaultProductThumbnail, {Key? key})
      : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: 340.w,
          height: 284.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/star.svg'),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '4.6',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontFamily: 'SM'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SizedBox(
                          height: double.infinity,
                          width: 200.w,
                          child: widget.productImageList.isEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedImage(
                                        imageUrl:
                                            widget.defaultProductThumbnail),
                                  ],
                                )
                              : CachedImage(
                                  imageUrl: widget
                                      .productImageList[widget.selectedItem]
                                      .imageUrl),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/like.svg'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedItem = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 70.h,
                          width: 70.w,
                          margin: EdgeInsets.only(left: 20.w),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: widget.selectedItem == index
                                ? Border.all(
                                    width: 2,
                                    color: CustomColors.blue,
                                  )
                                : Border.all(
                                    width: 1,
                                    color: CustomColors.grey,
                                  ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: CachedImage(
                            imageUrl: widget.productImageList[index].imageUrl,
                            radius: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              },
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  final VariantType variantType;
  final List<BasketItemVariant> basketItemVariantList;

  const ColorVariantList(
      this.variantList, this.variantType, this.basketItemVariantList,
      {Key? key})
      : super(key: key);

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  BasketItemVariant? basketItemColorVariant;

  @override
  void initState() {
    basketItemColorVariant = BasketItemVariant(
        widget.variantType, widget.variantList[_selectedIndex]);

    widget.basketItemVariantList.add(basketItemColorVariant!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          itemCount: widget.variantList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                basketItemColorVariant!.variant = widget.variantList[index];
                if (widget.basketItemVariantList.any((element) =>
                    element.variantType.type == VariantTypeEnum.COLOR)) {
                  widget.basketItemVariantList.removeWhere((element) =>
                      element.variantType.type == VariantTypeEnum.COLOR);
                  widget.basketItemVariantList.add(basketItemColorVariant!);
                } else {
                  widget.basketItemVariantList.add(basketItemColorVariant!);
                }

                // for (var item in widget.basketItemVariantList) {
                //   print(
                //       'Type Is ${item.variantType.name} , Value Is ${item.variant.name}');
                // }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: 10.w),
              height: 26,
              width: _selectedIndex == index ? 66 : 26,
              decoration: BoxDecoration(
                color:
                    Color(int.parse('0xff${widget.variantList[index].value}')),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Visibility(
                visible: _selectedIndex == index,
                child: Center(
                  child: Text(
                    widget.variantList[index].name!,
                    style: theme.textTheme.bodySmall!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.onSecondary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  final List<Variant> storageVariants;
  final VariantType variantType;
  final List<BasketItemVariant> basketItemVariantList;

  const StorageVariantList(
      this.storageVariants, this.variantType, this.basketItemVariantList,
      {Key? key})
      : super(key: key);

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  BasketItemVariant? basketItemStorageVariant;

  @override
  void initState() {
    basketItemStorageVariant = BasketItemVariant(
        widget.variantType, widget.storageVariants[_selectedIndex]);
    widget.basketItemVariantList.add(basketItemStorageVariant!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          itemCount: widget.storageVariants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                basketItemStorageVariant!.variant =
                    widget.storageVariants[index];

                if (widget.basketItemVariantList.any((element) =>
                    element.variantType.type == VariantTypeEnum.STORAGTE)) {
                  widget.basketItemVariantList.removeWhere((element) =>
                      element.variantType.type == VariantTypeEnum.STORAGTE);
                  widget.basketItemVariantList.add(basketItemStorageVariant!);
                } else {
                  widget.basketItemVariantList.add(basketItemStorageVariant!);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: 10.w),
              height: 26.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: _selectedIndex == index
                    ? Border.all(color: CustomColors.blueIndicator, width: 2)
                    : Border.all(color: CustomColors.grey, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value!,
                    style: theme.textTheme.bodySmall!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<BasketItemVariant> _getBasketItemVariants(
    List<BasketItemVariant> variantList) {
  if (variantList.isEmpty) return [];

  List<BasketItemVariant> basketItemVariantList = [];

  for (var basketItemVariant in variantList) {
    Variant finalVariant =
        variantList[variantList.indexOf(basketItemVariant)].variant;
    VariantType finalVariantType =
        variantList[variantList.indexOf(basketItemVariant)].variantType;

    basketItemVariantList
        .add(BasketItemVariant(finalVariantType, finalVariant));
  }

  if (basketItemVariantList[0].variantType.type != VariantTypeEnum.COLOR) {
    basketItemVariantList = basketItemVariantList.reversed.toList();
  }
  return basketItemVariantList;
}
