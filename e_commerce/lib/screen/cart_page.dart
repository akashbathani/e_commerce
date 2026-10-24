import 'package:e_commerce/bloc/cart/delete/delete_cart_bloc.dart';
import 'package:e_commerce/bloc/cart/delete/delete_cart_event.dart';
import 'package:e_commerce/bloc/cart/delete/delete_cart_state.dart';
import 'package:e_commerce/bloc/cart/view_cart/view_cart_bloc.dart';
import 'package:e_commerce/bloc/cart/view_cart/view_cart_event.dart';
import 'package:e_commerce/bloc/cart/view_cart/view_cart_state.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  final String cartId;
  const CartPage({super.key, required this.cartId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<ViewCartBloc>().add(ViewCartFetchEvent(cartId: "2"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.white, size: 18),
        ),
        backgroundColor: AppColor.mainColor,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: mTextStyle18(
            mFontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              BlocConsumer<DeleteCartBloc, DeleteCartState>(
                listener: (context, state) {
                  if (state is DeleteCartLoadingState) {
                    isLoading = true;
                  }
                  if (state is DeleteCartFailureState) {
                    isLoading = false;
                    AppSnackbar.showError(context, state.errorMsg);
                  }
                  if (state is DeleteCartSuccessState) {
                    isLoading = false;

                    AppSnackbar.showSuccess(context, "Delete item succesfully");
                    context.read<ViewCartBloc>().add(
                      ViewCartFetchEvent(cartId: "2"),
                    );
                  }
                },
                builder: (context, state) {
                  return BlocConsumer<ViewCartBloc, ViewCartState>(
                    listener: (context, state) {
                      if (state is ViewCartLoadingState) {
                        isLoading = true;
                      }
                      if (state is ViewCartFailureState) {
                        isLoading = false;
                        AppSnackbar.showError(context, state.errorMsg);
                      }
                      if (state is ViewCartILoadedState) {
                        isLoading = false;
                        AppSnackbar.showSuccess(
                          context,
                          "Cart fetch succesfully",
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ViewCartLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.mainColor,
                          ),
                        );
                      }
                      if (state is ViewCartFailureState) {
                        return Center(child: Text(state.errorMsg));
                      }
                      if (state is ViewCartILoadedState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.viewCartData.length,
                          itemBuilder: (context, index) {
                            var cart = state.viewCartData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(cart.image!),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    cart.name!,
                                                    style: mTextStyle20(
                                                      mFontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                IconButton(
                                                  onPressed: () {
                                                    debugPrint(
                                                      "Delete pressed: ${cart.id}",
                                                    );
                                                    context
                                                        .read<DeleteCartBloc>()
                                                        .add(
                                                          DeleteCartEventt(
                                                            cartId: cart.id
                                                                .toString(),
                                                          ),
                                                        );
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹ ${cart.price!}",
                                                  style: mTextStyle16(
                                                    mFontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                    color: AppColor.mainColor
                                                        .withValues(alpha: 0.7),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 4,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.remove,
                                                          size: 12,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          cart.quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    elevation: 5,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Create Order",
                    style: mTextStyle18(
                      mFontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
