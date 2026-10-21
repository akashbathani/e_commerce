import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/bloc/cart/add_cart/add_cart_bloc.dart';
import 'package:e_commerce/bloc/cart/add_cart/add_cart_event.dart';
import 'package:e_commerce/bloc/cart/add_cart/add_cart_state.dart';
import 'package:e_commerce/bloc/category/category_bloc.dart';
import 'package:e_commerce/bloc/category/category_event.dart';
import 'package:e_commerce/bloc/category/category_state.dart';
import 'package:e_commerce/bloc/product/product_bloc.dart';
import 'package:e_commerce/bloc/product/product_event.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/screen/notification/notification_page.dart';
import 'package:e_commerce/screen/product_detail_page.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> banners = [
    "asset/image/banner_5.png",
    "asset/image/banner_4.png",
    "asset/image/banner_3.png",
    "asset/image/banner_2.png",
  ];

  int currentIndex = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  int quantity = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetchEvent());
    context.read<CategoryBloc>().add(CategoryFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ======== HEADER =========
                  header(),

                  SizedBox(height: 30),

                  // ======== SEARCH BAR =========
                  searchbar(),

                  SizedBox(height: 30),

                  // ======== BANNER =========
                  banner(),

                  SizedBox(height: 30),

                  // ======== CATEGORY =========
                  categoryWiseproduct(),

                  // // ======== PRODUCT GRIDVIEW =========
                  SizedBox(height: 15),

                  Text(
                    "Special For You",
                    style: mTextStyle16(mFontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 15),

                  /// PRODUCT
                  productList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.grey.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Image.asset("asset/image/dashboardd.png", height: 22),
            ),
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.grey.withOpacity(0.3),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              icon: Icon(Icons.notifications_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Widget searchbar() {
    return SizedBox(
      height: 50,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: AppColor.grey),
          suffixIcon: Icon(Icons.sort, color: AppColor.grey),
          hintText: "Search...",
          hintStyle: TextStyle(color: AppColor.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget categoryWiseproduct() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryFailureState) {
          return Center(child: Text(state.errorMsg));
        }

        if (state is CategoryLoadedState) {
          return SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categoryData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          child: Text(
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            state.categoryData[index].name ?? "",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget banner() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: CarouselSlider.builder(
            carouselController: buttonCarouselController,

            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemCount: banners.length,
            itemBuilder: (context, index, _) {
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(banners[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: currentIndex == index ? 14 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppColor.mainColor
                      : AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget productList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        }
        if (state is ProductFailureState) {
          return Center(child: Text(state.errorMsg));
        }
        if (state is ProductLoadedState) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              mainAxisExtent: 310,
            ),
            itemCount: state.productData.length,
            itemBuilder: (context, index) {
              final product = state.productData[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(12),
                            ),
                            color: Colors.deepOrange,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "asset/image/heart.png",
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Image(
                          image: NetworkImage(product.image ?? ""),
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              product.name!,
                              style: mTextStyle18(mFontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              product.price!,
                              style: mTextStyle20(mFontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<AddCartBloc, AddCartState>(
                        listener: (context, state) {
                          if (state is AddCartLoadingState) {
                            isLoading = true;
                          }
                          if (state is AddCartFailureState) {
                            isLoading = false;
                            AppSnackbar.showError(context, state.errorMsg);
                          }
                          if (state is AddCartLoadedState) {
                            isLoading = false;
                            AppSnackbar.showSuccess(
                              context,
                              "Item added successfully",
                            );
                          }
                        },
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                                minimumSize: Size(200, 45),
                              ),
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                context.read<AddCartBloc>().add(
                                  AddCartQuantityEvent(
                                    productId: product.id!,
                                    userId: "1",
                                    qty: "10",
                                  ),
                                );
                              },
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.white,
                                      ),
                                    )
                                  : Text(
                                      "Add to cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
