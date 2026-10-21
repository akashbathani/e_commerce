import 'package:e_commerce/bloc/order/order_bloc.dart';
import 'package:e_commerce/bloc/order/order_event.dart';
import 'package:e_commerce/bloc/order/order_state.dart';
import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final String userId;
  const OrderPage({super.key, required this.userId});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;
  DateFormat df = DateFormat('dd MMM yyyy, hh:mm a');
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderFetchEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start: upar
            end: Alignment.bottomCenter, // Stop: neeche
            colors: [AppColor.mainColor.withOpacity(0.7), AppColor.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios, size: 16),
                        ),
                      ),
                      Text(
                        "My Cart",
                        style: mTextStyle18(
                          // color: AppColor.white,
                          mFontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                BlocConsumer<OrderBloc, OrderState>(
                  listener: (context, state) {
                    if (state is OrderLoadingState) {
                      isLoading = true;
                    }
                    if (state is OrderFailureState) {
                      isLoading = false;
                      AppSnackbar.showError(context, state.errorMsg);
                    }

                    if (state is OrderLoadedState) {
                      isLoading = false;
                      AppSnackbar.showSuccess(
                        context,
                        "Order Fetch Successfully.",
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is OrderLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColor.white),
                      );
                    }
                    if (state is OrderFailureState) {
                      return Center(child: Text(state.errorMsg));
                    }

                    if (state is OrderLoadedState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.getorderModel.orders?.length ?? 0,
                        itemBuilder: (context, index) {
                          final order = state.getorderModel.orders![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: order.product?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final product = order.product![index];
                                        return ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  product.image!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total: ${order.totalAmount.toString()},",
                                          style: mTextStyle16(
                                            mFontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          df.format(
                                            DateTime.parse(
                                              order.createdAt.toString(),
                                            ),
                                          ),
                                          style: mTextStyle14(
                                            mFontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
